package com.terrenceryan.finicky.vo
{
	public class Store
	{
		
		private var _storeid:int = 0;
		private var _name:String = "";
		private var _address:String = "";
		private var _city:String = "";
		private var _state:String = "";
		private var _mailingCode:String = "";
		private var _country:String = "";
		private var _lat:Number = 0;
		private var _lon:Number = 0;
		private var _notes:String = "";
		
		
		public function Store()
		{
		}

		public function get notes():String
		{
			return _notes;
		}

		public function set notes(value:String):void
		{
			_notes = value;
		}

		public function get lon():Number
		{
			return _lon;
		}

		public function set lon(value:Number):void
		{
			_lon = value;
		}

		public function get lat():Number
		{
			return _lat;
		}

		public function set lat(value:Number):void
		{
			_lat = value;
		}

		public function get country():String
		{
			return _country;
		}

		public function set country(value:String):void
		{
			_country = value;
		}

		public function get mailingCode():String
		{
			return _mailingCode;
		}

		public function set mailingCode(value:String):void
		{
			_mailingCode = value;
		}

		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
		}

		public function get city():String
		{
			return _city;
		}

		public function set city(value:String):void
		{
			_city = value;
		}

		public function get address():String
		{
			return _address;
		}

		public function set address(value:String):void
		{
			_address = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get storeid():int
		{
			return _storeid;
		}

		public function set storeid(value:int):void
		{
			_storeid = value;
		}

		public function toAddressString():String
		{
			var result:String = _address + " " + _city + " " + _state + " " + _mailingCode + " " + _country;
			trace(result);
			return result;
		}
	}
}