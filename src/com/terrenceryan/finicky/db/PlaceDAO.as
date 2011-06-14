package com.terrenceryan.finicky.db
{
	import com.terrenceryan.finicky.vo.Item;
	import com.terrenceryan.finicky.vo.Place;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	
	public class PlaceDAO
	{
		
		private var _conn:SQLConnection = new SQLConnection();
		
		public function PlaceDAO(conn:SQLConnection)
		{
			_conn = conn;
			createTable();
			
		}
		
		public function createTable():void
		{
			var createStmt:SQLStatement = new SQLStatement();
			createStmt.sqlConnection = _conn;
			var sql:String = "";
			sql += "CREATE TABLE IF NOT EXISTS place (";
			sql += "	placeid		INTEGER PRIMARY KEY,";
			sql += "	name	TEXT,";
			sql += "	address	TEXT,";
			sql += "	city	TEXT,";
			sql += "	state	TEXT,";
			sql += "	mailingcode	TEXT,";
			sql += "	country	TEXT,";
			sql += "	lat	TEXT,";
			sql += "	lon	TEXT,";
			sql += "	notes		TEXT";
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
		
		public function get(id:int):Place{
			var query:String = "";
			
			query = "SELECT * " + 
					"FROM  	place " + 
					"WHERE 	placeid = :placeid";
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			sqlSelect.parameters[":placeid"] = id;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			var place:Place = convertPlainObjectToPlace(result.data[0]);
			
			return place;
		}
		
		private function convertPlainObjectToPlace(obj:Object):Place
		{
			var place:Place = new Place();
			place.name = obj.name;
			place.address = obj.address;
			place.city = obj.city;
			place.state = obj.state;
			place.mailingCode = obj.mailingcode;
			place.country = obj.country;
			place.lat = obj.lat;
			place.lon = obj.lon;
			place.notes = obj.notes;
			return place;
		}		
		
		public function save(store:Place):void{
			var query:String = "INSERT INTO store (" + 
				"name," +
				"address," +
				"city," +
				"state," +
				"mailingCode," +
				"country," +
				"lat," +
				"lon," +
				"notes)" + 
				"VALUES ( " + 
				":name," +
				":address," +
				":city," +
				":state," +
				":mailingCode," +
				":country," +
				":lat," +
				":lon," +
				":notes)";
			
			var sqlInsert:SQLStatement = new SQLStatement();
			sqlInsert.sqlConnection = _conn;
			//sqlInsert.addEventListener( SQLEvent.RESULT, onSQLSave );
			//sqlInsert.addEventListener( SQLErrorEvent.ERROR, onSQLError );				
			
			sqlInsert.text = query;
			sqlInsert.parameters[":name"] = store.name;
			sqlInsert.parameters[":address"] = store.address;
			sqlInsert.parameters[":city"] = store.city;
			sqlInsert.parameters[":state"] = store.state;
			sqlInsert.parameters[":mailingCode"] = store.mailingCode;
			sqlInsert.parameters[":country"] = store.country;
			sqlInsert.parameters[":lat"] = store.lat;
			sqlInsert.parameters[":lon"] = store.lon;
			sqlInsert.parameters[":notes"] = store.notes;
			
			sqlInsert.execute();	
		}
		
	}
}