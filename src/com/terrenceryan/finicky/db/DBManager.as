package com.terrenceryan.finicky.db
{
	import flash.events.EventDispatcher;
	
	public class DBManager extends EventDispatcher
	{
		
		import flash.events.Event;
		
		
		import flash.data.SQLConnection;
		import flash.errors.SQLError;
		import flash.filesystem.File;
		
		private var _conn:SQLConnection = new SQLConnection();
		private var _itemDAO:ItemDAO = null;
		private var _storeDAO:StoreDAO = null;
		
		
		[Event(name="loaded", type="flash.events.Event")]
		
		
		public function DBManager(dbFile:File) 
		{
			
			try
			{
				_conn.open(dbFile);
				_itemDAO = new ItemDAO(_conn);
				_storeDAO = new StoreDAO(_conn);
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
		
		public function get storeDAO():StoreDAO
		{
			return _storeDAO;
		}
		
		public function set storeDAO(value:StoreDAO):void
		{
			_storeDAO = value;
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