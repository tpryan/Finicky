package com.terrenceryan.finicky.db
{
	import com.terrenceryan.finicky.vo.Place;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	
	import mx.collections.ArrayCollection;
	
	public class CurrentLocationDBO
	{
		private var _conn:SQLConnection = new SQLConnection();
		private var _defaultCurrentLocation:Place = new Place();
		
		public function CurrentLocationDBO(conn:SQLConnection)
		{
			_conn = conn;
			_defaultCurrentLocation.city = "Philadelphia";
			_defaultCurrentLocation.state = "PA";
			_defaultCurrentLocation.country = "USA";
			_defaultCurrentLocation.lat = 39.949579;
			_defaultCurrentLocation.lon = -75.166913;
			createTable();
			
			
		}
		
		public function createTable():void
		{
			var createStmt:SQLStatement = new SQLStatement();
			createStmt.sqlConnection = _conn;
			var sql:String = "";
			sql += "CREATE TABLE IF NOT EXISTS currentlocation (";
			sql += "	cacheid	INTEGER PRIMARY KEY,";
			sql += "	city	TEXT,";
			sql += "	state	TEXT,";
			sql += "	country	TEXT,";
			sql += "	lat	NUMERIC,";
			sql += "	lon	NUMERIC";
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
			
			if (count() == 0){
				save(_defaultCurrentLocation);
			}
		}
		
		public function save(place:Place):void{
			var query:String = "INSERT OR REPLACE INTO currentlocation (" + 
				"cacheid, " +
				"city, " +
				"state, " +
				"country, " +
				"lat, " +
				"lon) " + 
				"VALUES ( " +
				"1, "+
				":city, " +
				":state, " +
				":country, " +
				":lat, " +
				":lon)";
			
			var sqlInsert:SQLStatement = new SQLStatement();
			sqlInsert.sqlConnection = _conn;
			//sqlInsert.addEventListener( SQLEvent.RESULT, onSQLSave );
			//sqlInsert.addEventListener( SQLErrorEvent.ERROR, onSQLError );				
			
			sqlInsert.text = query;
			sqlInsert.parameters[":city"] = place.city;
			sqlInsert.parameters[":state"] = place.state;
			sqlInsert.parameters[":country"] = place.country;
			sqlInsert.parameters[":lat"] = place.lat;
			sqlInsert.parameters[":lon"] = place.lon;
			
			sqlInsert.execute();	
		}
		
		
		public function get():Place{
			var query:String = "";
			
			query = "SELECT * " + 
				"FROM  currentlocation " + 
				"WHERE cacheid = 1";
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			var place:Place = new Place();
			place.city = result.data[0].city;
			place.state = result.data[0].state;
			place.country = result.data[0].country;
			place.lat = result.data[0].lat;
			place.lon = result.data[0].lon;
			
			return place;
		}
		
		public function count():int{
			var query:String = "";
			
			
			query = "SELECT 	count(*) as count " +
				"FROM currentlocation"; 
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			
			var count:int = result.data[0].count;
			
			
			return count;
			
		}
		
	}
	
	
}