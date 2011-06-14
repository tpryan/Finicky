package com.terrenceryan.finicky.util
{
	public class SQLiteASDateHelper
	{
		public function SQLiteASDateHelper()
		{
		}
		
		public function dateFromAStoSQLite(date:Date):String{
			var result:String = "";
			
			result = result.concat(date.getFullYear(), "-", prependZeros(date.getMonth()+1), "-", prependZeros(date.getDate()));
			result = result.concat(" ");
			result = result.concat(prependZeros(date.getHours()), ":", prependZeros(date.getMinutes()), ":", prependZeros(date.getSeconds()));
			return result;
		}
		
		public function dateFromSQLiteToAS(str:String):Date{
			var _str:String = str;
			var dtArray:Array = _str.split(" ");
			var dateArray:Array = dtArray[0].toString().split("-");
			var timeArray:Array = dtArray[1].toString().split(":");
			var result:Date = new Date(dateArray[0], dateArray[1]-1, dateArray[2], timeArray[0], timeArray[1], timeArray[2]);
			
			return result;
		}
		
		private function prependZeros(num:int):String{
			var result:String = num.toString();
			
			if (result.length == 1){
				result = "0".concat(result);
			}
			
			return result;
		}
	}
}