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
		
		private var _conn:SQLConnection;
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
		
		public function count():int{
			var query:String = "";
			
			
			query = "SELECT 	count(*) as count " +
				"FROM 		itemAtPlace p "; 
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			
			var count:int = result.data[0].count;
			
			
			return count;
			
		}
		
		
		public function list(orderby:String="item.name",otherPlace:Place = null, tolerance:int = 1):ArrayCollection{
			var query:String = "";
			
			if (otherPlace){
				var latmin:Number = otherPlace.lat - tolerance; 
				var latmax:Number = otherPlace.lat + tolerance; 
				var lonmin:Number = otherPlace.lon - tolerance; 
				var lonmax:Number = otherPlace.lon + tolerance; 
				
				
				query = "SELECT 	ip.* " +
					"FROM 		itemAtPlace ip " +
					
					"JOIN 		item i on i.itemid=ip.itemid " +
					"JOIN 		place p on p.placeid=ip.placeid " +
					"WHERE 		p.lat BETWEEN " + latmin.toString() + " AND " + latmax.toString() + " " +
					"AND 		p.lon BETWEEN " + lonmin.toString() + " AND " + lonmax.toString() + " " +
					"ORDER BY 	i.name "; 
			}	
			else{
				
			
				query = "SELECT 	ip.* " +
						"FROM 		itemAtPlace ip " +
						
						"JOIN 		item i on i.itemid=ip.itemid " +
						"JOIN 		place p on p.placeid=ip.placeid " +
						"ORDER BY 	i.name "; 
			}	
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
		
		public function get(itemid:int, placeid:int):ItemAtPlace{
			var query:String = "";
			
			
			query = "SELECT 	p.* " +
				"FROM 		itemAtPlace p " +
				"WHERE		itemid = :itemid " +
				"AND		placeid = :placeid "; 
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			
			sqlSelect.text = query;
			sqlSelect.parameters[":itemid"] = itemid;
			sqlSelect.parameters[":placeid"] = placeid;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			if (result.data != null){
					var itemAtPlace:ItemAtPlace = convertPlainObjectToItemAtPlace(result.data[0]);
					
			}
			
			return itemAtPlace;
			
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
		
		public function destroy(itemAtPlace:ItemAtPlace):void {
			var query:String = "DELETE FROM itemAtPlace " + 
				"WHERE itemid = " + itemAtPlace.item.itemid + " " +
				"AND placeid = " + itemAtPlace.place.placeid + " ";
			
			var sqlInsert:SQLStatement = new SQLStatement();
			sqlInsert.sqlConnection = _conn;
			//sqlInsert.addEventListener( SQLEvent.RESULT, onSQLSave );
			//sqlInsert.addEventListener( SQLErrorEvent.ERROR, onSQLError );				
			
			sqlInsert.text = query;
			
			sqlInsert.execute();	
		}
		
		public function save(itemAtPlace:ItemAtPlace):void{
			
			destroy(itemAtPlace);
			
			if (!itemAtPlace.item.itemid || itemAtPlace.item.itemid == 0){
				_dbmanager.itemDAO.save(itemAtPlace.item);
				itemAtPlace.item.itemid = _dbmanager.itemDAO.getLastRecordID(); 
			}
			
			if (!itemAtPlace.place.placeid || itemAtPlace.place.placeid == 0){
				_dbmanager.placeDAO.save(itemAtPlace.place);
				itemAtPlace.place.placeid = _dbmanager.placeDAO.getLastRecordID(); 
			}
			
			
			
			var query:String = "INSERT INTO main.itemAtPlace (" + 
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