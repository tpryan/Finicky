package com.terrenceryan.finicky.vo
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="dataChanged", type="flash.events.Event")]

	public class Place extends EventDispatcher
	{
		
		private const FEET_IN_MILE:int = 5280;
		private const M_IN_KM:int  = 1000; //yes I know this is stupid.
		private const RADIUS_OF_EARTH_IN_MILES:int = 3963;
		private const RADIUS_OF_EARTH_IN_FEET:int =20925525;
		private const RADIUS_OF_EARTH_IN_KM:int =6378;
		private const RADIUS_OF_EARTH_IN_M:int =6378000;
		
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
		private var _measure:String = "US";
		
		
		public function Place()
		{
		}

		public function get measure():String
		{
			return _measure;
		}

		public function set measure(value:String):void
		{
			_measure = value;
		}

		[Bindable]
		public function get country():String
		{
			return _country;
		}

		public function set country(value:String):void
		{
			_country = value;
			announceChange()
		}

		[Bindable]
		public function get mailingCode():String
		{
			return _mailingCode;
			
		}

		public function set mailingCode(value:String):void
		{
			_mailingCode = value;
			announceChange();
		}

		[Bindable]
		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
			announceChange();
		}

		[Bindable]
		public function get city():String
		{
			return _city;
		}

		public function set city(value:String):void
		{
			_city = value;
			announceChange();
		}

		[Bindable]
		public function get address():String
		{
			return _address;
		}

		public function set address(value:String):void
		{
			_address = value;
			announceChange();
		}

		[Bindable]
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
			announceChange();
		}

		[Bindable]
		public function get placeid():int
		{
			return _placeid;
		}

		public function set placeid(value:int):void
		{
			_placeid = value;
			announceChange();
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
			announceChange();
		}
		[Bindable]
		public function get lon():Number
		{
			return _lon;
		}

		public function set lon(value:Number):void
		{
			_lon = value;
			announceChange();
		}
		[Bindable]
		public function get lat():Number
		{
			return _lat;
		}

		public function set lat(value:Number):void
		{
			_lat = value;
			announceChange();
		}

		

		public function toAddressString():String
		{
			var result:String = _address + " " + _city + " " + _state + " " + _mailingCode + " " + _country;
			trace(result);
			return result;
		}
		
		public function toCityStateZipString():String
		{
			var result:String = _city + ", " + _state + " " + _mailingCode;
			trace(result);
			return result;
		}
		
		public function getCityStateString():String
		{
			var result:String = "";
			
			if (( _city.length > 0) && (_state.length > 0) ){
				result = _city + ", " + _state;
			}
			else if ((_city.length == 0) && (_state.length == 0) ){
				result = "Where are you?";
			}
			else{
				result = _city + " " + _state;
			}
			return result;
		}
		
		public function getCityCountryString():String
		{
			var result:String = "";
			
			if (( _city.length > 0) && (_country.length > 0) ){
				result = _city + ", " + _country;
			}
			else if ((_city.length == 0) && (_country.length == 0) ){
				result = "Where are you?";
			}
			else{
				result = _city + " " + _country;
			}
			return result;
		}
		
		public function getRendererLabel():String
		{
			var result:String = "";
			
			if ((_country && _country.indexOf("United States") < 0) &&
				(_country && _country.indexOf("USA") < 0)){
				result = getCityCountryString();
			}
			else if (_city && _state ){
				result = getCityStateString();
			}
			else if (_city && _country ){
				result = getCityCountryString();
			}
			else{
				result = _city;
			}
			return result + String.fromCharCode(32);
		}
		
		public function getDistanceInHumanForm():String{
			var result:String = "";
			var digits:String;
			
			var smallUnit:String = "ft";
			var largeUnit:String = "mi";
			var threshold:int = 500;
			var divider:int = FEET_IN_MILE;
			
			if (measure == "metric"){
				smallUnit = "m";
				largeUnit = "km";
				threshold = 150;
				divider = M_IN_KM;
				
			}
			
			if (_distance < threshold){
				digits = _distance.toFixed(0);
				result = digits.toString() + smallUnit;
			}
			else{
				var temp:Number = _distance / divider;
				digits = temp.toFixed(2);
				result =  digits + largeUnit;
			}	
			
			return result;
		}
		
		
		public function distanceFromPlace(place:Place):Number{
			
			var unit:String = "feet";
			if (measure == "metric"){
				unit = "meters";
			}
			
			var d:Number = distanceBetweenCoordinates(_lat,_lon,place.lat,place.lon, unit);
			return d;
		}
		
		private function distanceBetweenCoordinates(lat1:Number,lon1:Number,
													lat2:Number,lon2:Number,
													units:String="miles"):Number{
		
			var R:int = RADIUS_OF_EARTH_IN_MILES;
			if (units == "km"){
				R = RADIUS_OF_EARTH_IN_KM;
			}
			if (units == "meters"){
				R = RADIUS_OF_EARTH_IN_M;
			}
			if (units =="feet"){
				R= RADIUS_OF_EARTH_IN_FEET;
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
		
		public function clone():Place{
			var result:Place = new Place();
			result.placeid = _placeid;
			result.name = _name;
			result.address = _address;
			result.city = _city;
			result.state = _state;
			result.mailingCode = _mailingCode;
			result.country = _country;
			result.lat = _lat;
			result.lon = _lon;
			result.notes = _notes;
			trace("Place cloned")
			return result;
			
		}
		
		public function announceChange():void{
			dispatchEvent(new Event("dataChanged"));
		}
		
		
	}
}