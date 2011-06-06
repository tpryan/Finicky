package com.terrenceryan.finicky.db
{
	import com.terrenceryan.finicky.vo.Item;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	
	import mx.collections.ArrayCollection;

	public class ItemDAO
	{
		
		private var _conn:SQLConnection = new SQLConnection();
		
		
		public function ItemDAO(conn:SQLConnection)
		{
			_conn = conn;
			createTable();
			
			
		}
		
		
		public function createTable():void
		{
			var createStmt:SQLStatement = new SQLStatement();
			createStmt.sqlConnection = _conn;
			var sql:String = "";
			sql += "CREATE TABLE IF NOT EXISTS item (";
			sql += "	itmemid		INTEGER PRIMARY KEY,";
			sql += "	name	TEXT,";
			sql += "	description		TEXT";
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
		
		public function list():ArrayCollection{
			var query:String = "";
			
			query = "SELECT * " + 
				"FROM  item ";
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			trace("yo");
			
			var ac:ArrayCollection = new ArrayCollection();
			if (result.data != null){
				for (var i:int = 0; i < result.data.length; i++){
					var item:Item = new Item();
					item.itemid = result.data[i].itemid;
					item.name = result.data[i].name;
					item.description = result.data[i].description;
					ac.addItem(item);
				}
			}
			return ac;
			
		}
		public function save(item:Item):void {
			var query:String = "INSERT INTO item (" + 
				"name," + 
				"description)" + 
				"VALUES ( " + 
				":name," + 
				":description)";
			
			var sqlInsert:SQLStatement = new SQLStatement();
			sqlInsert.sqlConnection = _conn;
			//sqlInsert.addEventListener( SQLEvent.RESULT, onSQLSave );
			//sqlInsert.addEventListener( SQLErrorEvent.ERROR, onSQLError );				
			
			sqlInsert.text = query;
			sqlInsert.parameters[":name"] = item.name;
			sqlInsert.parameters[":description"] = item.description; 
			
			sqlInsert.execute();	
		}
		
	}
}