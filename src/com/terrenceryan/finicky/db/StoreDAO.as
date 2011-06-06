package com.terrenceryan.finicky.db
{
	import com.terrenceryan.finicky.vo.Store;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	
	public class StoreDAO
	{
		
		private var _conn:SQLConnection = new SQLConnection();
		
		public function StoreDAO(conn:SQLConnection)
		{
			_conn = conn;
			createTable();
			
		}
		
		public function createTable():void
		{
			var createStmt:SQLStatement = new SQLStatement();
			createStmt.sqlConnection = _conn;
			var sql:String = "";
			sql += "CREATE TABLE IF NOT EXISTS store (";
			sql += "	storeid		INTEGER PRIMARY KEY,";
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
		
		public function save(store:Store):void{
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