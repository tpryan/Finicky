package com.terrenceryan.finicky.db
{
	import com.terrenceryan.finicky.vo.ItemAtPlace;
	
	import flash.events.EventDispatcher;
	
	public class DBManager extends EventDispatcher
	{
		
		import flash.events.Event;
		
		
		import flash.data.SQLConnection;
		import flash.errors.SQLError;
		import flash.filesystem.File;
		
		private var _conn:SQLConnection = new SQLConnection();
		private var _itemDAO:ItemDAO = null;
		private var _placeDAO:PlaceDAO = null;
		private var _itemAtPlaceDAO:ItemAtPlaceDAO = null;
		
		
		[Event(name="loaded", type="flash.events.Event")]
		
		
		public function DBManager(dbFile:File) 
		{
			
			try
			{
				_conn.open(dbFile);
				_itemDAO = new ItemDAO(_conn);
				_placeDAO = new PlaceDAO(_conn);
				_itemAtPlaceDAO = new ItemAtPlaceDAO(_conn,this);
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