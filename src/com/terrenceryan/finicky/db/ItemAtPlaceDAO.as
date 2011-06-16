package com.terrenceryan.finicky.db
{
	
	import com.terrenceryan.finicky.util.SQLiteASDateHelper;
	import com.terrenceryan.finicky.vo.ItemAtPlace;
	import com.terrenceryan.finicky.vo.Place;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	
	import mx.collections.ArrayCollection;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	
	
	public class ItemAtPlaceDAO
	{
		
		private var _conn:SQLConnection = new SQLConnection();
		private var _dbmanager:DBManager;
		private var dateUtil:SQLiteASDateHelper = new SQLiteASDateHelper();
		
		public function ItemAtPlaceDAO(conn:SQLConnection,dbmanager:DBManager)
		{
			_conn = conn;
			_dbmanager = dbmanager;
			createTable();
			
		}
		
		
		public function createTable():void
		{
			var createStmt:SQLStatement = new SQLStatement();
			createStmt.sqlConnection = _conn;
			var sql:String = "";
			sql += "CREATE TABLE IF NOT EXISTS itemAtPlace (";
			sql += "	itemid		INTEGER,";
			sql += "	placeid		INTEGER,";
			sql += "	notes	TEXT,";
			sql += "	date		TEXT,";
			sql += "	picturepath		TEXT";
			sql += ")";
			createStmt.text = sql;
			
			try
			{
				createStmt.execute();
			}
			catch (error:SQLError)
			{
				trace("Error creating table");
				trace("CREATE TABLE error:", error);
				trace("error.message:", error.message);
				trace("error.details:", error.details);
				return;
			}
		}
		
		
		public function list(orderby:String="item.name",otherPlace:Place = null):ArrayCollection{
			var query:String = "";
			
			
			query = "SELECT 	p.* " +
					"FROM 		itemAtPlace p " +
					"JOIN 		item i on i.itemid=p.itemid " +
					"ORDER BY 	i.name "; 
				
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			
			var ac:ArrayCollection = new ArrayCollection();
			if (result.data != null){
				for (var i:int = 0; i < result.data.length; i++){
					var itemAtPlace:ItemAtPlace = convertPlainObjectToItemAtPlace(result.data[i]);
					
					if (otherPlace){
						itemAtPlace.place.otherPlace = otherPlace;
					}
					
					ac.addItem(itemAtPlace);
				}
			}
			
			
			if (orderby == "distance" && otherPlace != null){
				var sort:Sort = new Sort();
				sort.compareFunction = distanceCompare;
				ac.sort = sort;
				ac.refresh();
			}
			
			
			return ac;
			
		}
		
		private function distanceCompare(a:Object, b:Object, fields:Array = null):int
		{
			var result:int = 0;
			
			if (a.place.distance < b.place.distance){
				result = -1	
			}
			else if (a.place.distance == b.place.distance){
				result = 0;
			}
			else{
				result = 1;
			}
			
			return result;
		}
		
		private function convertPlainObjectToItemAtPlace(obj:Object):ItemAtPlace
		{
			var itemAtPlace:ItemAtPlace = new ItemAtPlace();
			itemAtPlace.date = dateUtil.dateFromSQLiteToAS(obj.date);
			itemAtPlace.picturepath = obj.picturepath;
			itemAtPlace.notes = obj.notes;
			itemAtPlace.item = _dbmanager.itemDAO.get(obj.itemid); 
			itemAtPlace.place = _dbmanager.placeDAO.get(obj.placeid); 
			return itemAtPlace;
		}
		
		public function save(itemAtPlace:ItemAtPlace):void{
			if (!itemAtPlace.item.itemid || itemAtPlace.item.itemid == 0){
				_dbmanager.itemDAO.save(itemAtPlace.item);
				itemAtPlace.item.itemid = _dbmanager.itemDAO.getLastRecordID(); 
			}
			
			if (!itemAtPlace.place.placeid || itemAtPlace.place.placeid == 0){
				_dbmanager.placeDAO.save(itemAtPlace.place);
				itemAtPlace.place.placeid = _dbmanager.placeDAO.getLastRecordID(); 
			}
			
			var query:String = "INSERT INTO itemAtPlace (" + 
				"itemid, " + 
				"placeid, " +
				"notes, " +
				"date, " + 
				"picturepath) " + 
				"VALUES ( " + 
				":itemid, " + 
				":placeid, " +
				":notes, " +
				":date, " + 
				":picturepath) ";
				
				trace(query);
				
				var sqlInsert:SQLStatement = new SQLStatement();
				sqlInsert.sqlConnection = _conn;
				//sqlInsert.addEventListener( SQLEvent.RESULT, onSQLSave );
				//sqlInsert.addEventListener( SQLErrorEvent.ERROR, onSQLError );				
				
				sqlInsert.text = query;
				sqlInsert.parameters[":itemid"] = itemAtPlace.item.itemid;
				sqlInsert.parameters[":placeid"] = itemAtPlace.place.placeid;
				sqlInsert.parameters[":notes"] = itemAtPlace.notes;
				sqlInsert.parameters[":date"] = dateUtil.dateFromAStoSQLite(itemAtPlace.date);
				sqlInsert.parameters[":picturepath"] = itemAtPlace.picturepath;
				
				sqlInsert.execute();		
				
				
		}
		
	}
}