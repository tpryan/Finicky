package com.terrenceryan.finicky.db
{
	import com.terrenceryan.finicky.vo.Item;
	import com.terrenceryan.finicky.vo.ItemAtPlace;
	import com.terrenceryan.finicky.vo.Place;
	
	import flash.events.EventDispatcher;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class DBManager extends EventDispatcher
	{
		
		import flash.events.Event;
		
		
		import flash.data.SQLConnection;
		import flash.errors.SQLError;
		import flash.filesystem.File;

		private var _demoMode:Boolean = false;
		
		
		private var _demoFile:File;
		private var _dbFile:File;
		private var _conn:SQLConnection = new SQLConnection();
		private var _itemDAO:ItemDAO = null;
		private var _placeDAO:PlaceDAO = null;
		private var _itemAtPlaceDAO:ItemAtPlaceDAO = null;
		private var _currentLocationDBO:CurrentLocationDBO = null;
		
		
		[Event(name="loaded", type="flash.events.Event")]
		
		
		public function DBManager(dbFile:File) 
		{
			_dbFile = dbFile;
			_demoFile = _dbFile.parent.resolvePath('finickyDemo.db');
			
			if (_demoFile.exists){
				_dbFile = _demoFile;
				_demoMode = true;
			}
			
			
			try
			{
				_conn.open(_dbFile);
				_itemDAO = new ItemDAO(_conn);
				_placeDAO = new PlaceDAO(_conn);
				_itemAtPlaceDAO = new ItemAtPlaceDAO(_conn,this);
				_currentLocationDBO = new CurrentLocationDBO(_conn);
				onLoadComplete();
				
				
			}
			catch (error:SQLError)
			{
				trace("Error opening database");
				trace("error.message:", error.message);
				trace("error.details:", error.details);
				return;
			}
			
			
			
		}
		
		[Bindable]
		public function get demoMode():Boolean
		{
			return _demoMode;
		}

		public function set demoMode(value:Boolean):void
		{
			_demoMode = value;
			
			if (value){
				startDemo();
			}
			else{
				stopDemo();
			}
			
		}

		public function startDemo():void{
			_conn = new SQLConnection();
			_conn.open(_demoFile);
			_itemDAO = new ItemDAO(_conn);
			_placeDAO = new PlaceDAO(_conn);
			_itemAtPlaceDAO = new ItemAtPlaceDAO(_conn,this);
			_currentLocationDBO = new CurrentLocationDBO(_conn);
			loadDemoData();
			onLoadComplete();
		}
		
		private function loadDemoData():void{
			var id:String;
			
			var itemXML:XML = convertFileToXML(File.applicationDirectory.resolvePath("assets/demo/items.xml"));
			var placeXML:XML = convertFileToXML(File.applicationDirectory.resolvePath("assets/demo/places.xml"));
			var itemAtPlaceXML:XML = convertFileToXML(File.applicationDirectory.resolvePath("assets/demo/itemAtPlace.xml"));
			
			_conn.begin();
			
			for (id in itemXML.item){
				var item:Item = new Item();
				item.name = itemXML.item.name[id];
				_itemDAO.save(item);
			}
			
			for (id in placeXML.place){
				var place:Place = new Place();
				place.name = placeXML.place.name[id];
				place.address = placeXML.place.address[id];
				place.city = placeXML.place.city[id];
				place.state = placeXML.place.state[id];
				place.mailingCode = placeXML.place.mailingCode[id];
				place.lat = placeXML.place.lat[id];
				place.lon = placeXML.place.lon[id];
				_placeDAO.save(place);
			}
			
			for (id in itemAtPlaceXML.itemAtPlace){
				trace(itemAtPlaceXML.itemAtPlace.itemid[id]);
				
				var itemAtPlace:ItemAtPlace = new ItemAtPlace();
				itemAtPlace.item = _itemDAO.get(itemAtPlaceXML.itemAtPlace.itemid[id]);
				itemAtPlace.place = _placeDAO.get(itemAtPlaceXML.itemAtPlace.placeid[id]);
				itemAtPlace.date = new Date();
				_itemAtPlaceDAO.save(itemAtPlace);
			}
			
			_conn.commit();
			
		}
		
		private function convertFileToXML(xmlFile:File):XML{
			var fs:FileStream = new FileStream();
			fs.open(xmlFile, FileMode.READ);
			var results:XML = XML(fs.readUTFBytes(fs.bytesAvailable));
			fs.close();
			return results;
		}
		
		
		
		public function stopDemo():void{
			_conn = new SQLConnection();
			_conn.open(_dbFile);
			_itemDAO = new ItemDAO(_conn);
			_placeDAO = new PlaceDAO(_conn);
			_itemAtPlaceDAO = new ItemAtPlaceDAO(_conn,this);
			_currentLocationDBO = new CurrentLocationDBO(_conn);
			
			try
			{
				_demoFile.deleteFile();
			} 
			catch(error:Error) 
			{
				trace(error.message);
			}
			
			onLoadComplete();
		}
		
		public function get currentLocationDBO():CurrentLocationDBO
		{
			return _currentLocationDBO;
		}

		public function set currentLocationDBO(value:CurrentLocationDBO):void
		{
			_currentLocationDBO = value;
		}

		public function get itemAtPlaceDAO():ItemAtPlaceDAO
		{
			return _itemAtPlaceDAO;
		}

		public function set itemAtPlaceDAO(value:ItemAtPlaceDAO):void
		{
			_itemAtPlaceDAO = value;
		}

		public function get placeDAO():PlaceDAO
		{
			return _placeDAO;
		}
		
		public function set placeDAO(value:PlaceDAO):void
		{
			_placeDAO = value;
		}
		
		public function get itemDAO():ItemDAO
		{
			return _itemDAO;
		}
		
		public function set itemDAO(value:ItemDAO):void
		{
			_itemDAO = value;
		}
		
		public function onLoadComplete():void {
			dispatchEvent(new Event("loaded",true));
		}
		
		
		
	}
}