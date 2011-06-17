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
		private var _table:String = "item";
		
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
			sql += "	itemid		INTEGER PRIMARY KEY,";
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
				"FROM  item " +
				"ORDER BY name";
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			
			var ac:ArrayCollection = new ArrayCollection();
			if (result.data != null){
				for (var i:int = 0; i < result.data.length; i++){
					var item:Item = convertPlainObjectToItem(result.data[i]);
					ac.addItem(item);
				}
			}
			return ac;
			
		}
		
		public function get(id:int):Item{
			var query:String = "";
			
			query = "SELECT * " + 
					"FROM  	item " + 
					"WHERE 	itemid = :itemid";
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			sqlSelect.parameters[":itemid"] = id;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			var item:Item = convertPlainObjectToItem(result.data[0]);
			
			return item;
		}
		
		public function getItemByName(name:String):Item{
			var query:String = "";
			
			query = "SELECT * " + 
				"FROM  	item " + 
				"WHERE name = :name";
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			sqlSelect.parameters[":name"] = name;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			var item:Item = new Item();
			if (result.data && result.data.length > 0){
				item = convertPlainObjectToItem(result.data[0]);
			}
			return item;
		}
		
		private function convertPlainObjectToItem(obj:Object):Item
		{
			var item:Item = new Item();
			item.itemid = obj.itemid;
			item.name = obj.name;
			item.description = obj.description;
			return item;
		}		
		
		public function save(item:Item):void {
			if(item.itemid != 0){
				update(item);
			}
			else{
				insert(item);
			}
		}
		
		public function insert(item:Item):void {
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
		
		public function destroy(item:Item):void {
			var query:String = "DELETE FROM item " + 
				"WHERE itemid = " + item.itemid + " ";
			
			var sqlInsert:SQLStatement = new SQLStatement();
			sqlInsert.sqlConnection = _conn;
			//sqlInsert.addEventListener( SQLEvent.RESULT, onSQLSave );
			//sqlInsert.addEventListener( SQLErrorEvent.ERROR, onSQLError );				
			
			sqlInsert.text = query;
			
			sqlInsert.execute();	
		}
		
		public function update(item:Item):void {
			var query:String = "UPDATE item " + 
				"set " + 
				"name ='" + item.name +  "', " + 
				"description ='" + item.description +  "' " +
				"WHERE itemid = " + item.itemid + " ";
			
			var sqlInsert:SQLStatement = new SQLStatement();
			sqlInsert.sqlConnection = _conn;
			//sqlInsert.addEventListener( SQLEvent.RESULT, onSQLSave );
			//sqlInsert.addEventListener( SQLErrorEvent.ERROR, onSQLError );				
			
			sqlInsert.text = query;
			
			sqlInsert.execute();	
		}
		
		public function getLastRecordID():int{
			var query:String = "";
			
			query = "SELECT last_insert_rowid() as id";
			
			var sqlSelect:SQLStatement = new SQLStatement();
			sqlSelect.sqlConnection = _conn;
			
			sqlSelect.text = query;
			sqlSelect.execute();
			var result:SQLResult =  sqlSelect.getResult();
			
			var lastID:int = result.data[0].id;
			
			return lastID;
		}
		
	}
}