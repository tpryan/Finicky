package com.terrenceryan.finicky.db
{
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	
	
	public class MeasureDBO
	{
		
		private var _conn:SQLConnection = new SQLConnection();
		
		public function MeasureDBO(conn:SQLConnection)
		{
			_conn = conn;
			createTable();
		}
		
		public function createTable():void
		{
			var createStmt:SQLStatement = new SQLStatement();
			createStmt.sqlConnection = _conn;
			var sql:String = "";
			sql += "CREATE TABLE IF NOT EXISTS measure (";
			sql += "	measureid	INTEGER PRIMARY KEY,";
			sql += "	type	TEXT";
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
				save("US");
			}
			
			
		}
		
		public function count():int{
			var query:String = "";
			
			
			query = "SELECT 	count(*) as count " +
				"FROM measure"; 
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			
			var count:int = result.data[0].count;
			
			
			return count;
			
		}
		
		public function get():String{
			var query:String = "";
			
			query = "SELECT * " + 
				"FROM  measure " + 
				"WHERE measureid = 1";
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			return result.data[0].type;
		}
		
		public function save(type:String):void{
			var query:String = "INSERT OR REPLACE INTO measure (" + 
				"measureid, " +
				"type) " + 
				"VALUES ( " +
				"1, "+
				":type)";
			
			var sqlInsert:SQLStatement = new SQLStatement();
			sqlInsert.sqlConnection = _conn;
			//sqlInsert.addEventListener( SQLEvent.RESULT, onSQLSave );
			//sqlInsert.addEventListener( SQLErrorEvent.ERROR, onSQLError );				
			
			sqlInsert.text = query;
			sqlInsert.parameters[":type"] = type;
			
			sqlInsert.addEventListener(SQLErrorEvent.ERROR, handleError);
			
			trace("recording lat ")
			trace("lat" )
			
			sqlInsert.execute();	
		}
		
		protected function handleError(event:SQLErrorEvent):void
		{
			trace(event.error.message);
			
		}	
		
		
	}
}