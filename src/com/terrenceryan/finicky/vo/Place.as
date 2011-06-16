package com.terrenceryan.finicky.vo
{
	public class Place
	{
		
		private var _placeid:int = 0;
		private var _name:String = "";
		private var _address:String = "";
		private var _city:String = "";
		private var _state:String = "";
		private var _mailingCode:String = "";
		private var _country:String = "";
		private var _lat:Number = 0;
		private var _lon:Number = 0;
		private var _notes:String = "";
		private var _distance:Number = 0;
		private var _otherPlace:Place;
		
		public function Place()
		{
		}

		public function get otherPlace():Place
		{
			return _otherPlace;
		}

		public function set otherPlace(value:Place):void
		{
			_otherPlace = value;
			_distance = distanceFromPlace(_otherPlace);
		}

		public function get distance():Number
		{
			return _distance;
		}

		[Bindable]
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

		[Bindable]	
		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
		}

		[Bindable]
		public function get city():String
		{
			return _city;
		}

		public function set city(value:String):void
		{
			_city = value;
		}
		
		[Bindable]
		public function get address():String
		{
			return _address;
		}

		public function set address(value:String):void
		{
			_address = value;
		}

		[Bindable]
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get placeid():int
		{
			return _placeid;
		}

		public function set placeid(value:int):void
		{
			_placeid = value;
		}

		public function toAddressString():String
		{
			var result:String = _address + " " + _city + " " + _state + " " + _mailingCode + " " + _country;
			trace(result);
			return result;
		}
		
		public function toCityStateZipString():String
		{
			var result:String = _city + " " + _state + " " + _mailingCode;
			trace(result);
			return result;
		}
		
		public function distanceFromPlace(place:Place):Number{
			var d:Number = distanceBetweenCoordinates(_lat,_lon,place.lat,place.lon);
			return d;
		}
		
		private function distanceBetweenCoordinates(lat1:Number,lon1:Number,
													lat2:Number,lon2:Number,
													units:String="miles"):Number{
		
			var R:int = 6371;
			if (units == "miles"){
				R = 3963;
			}
			
			var dLat:Number = (lat2-lat1) * Math.PI/180;
			var dLon:Number = (lon2-lon1) * Math.PI/180;
			
			var lat1inRadians:Number = lat1 * Math.PI/180;
			var lat2inRadians:Number = lat2 * Math.PI/180;
			
			var a:Number = Math.sin(dLat/2) * Math.sin(dLat/2) + 
							Math.sin(dLon/2) * Math.sin(dLon/2) * 
							Math.cos(lat1inRadians) * Math.cos(lat2inRadians);
			var c:Number = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
			var d:Number = R * c;
			
			return d;
		}
		
		
		
	}
}