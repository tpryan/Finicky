package com.terrenceryan.finicky.geo
{
	import com.terrenceryan.finicky.vo.Place;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	[Event(name="reverseGeoCodeResult", type="GeoResultEvent")]
	[Event(name="geoCodeResult", type="GeoResultEvent")]
	[Event(name="alternativesResult", type="GeoResultEvent")]
	
	public class GoogleGeoCode extends EventDispatcher
	{
		private const URL:String = "http://maps.googleapis.com/maps/api/geocode/xml";
		private var svc:HTTPService = new HTTPService();

		public var placeid:int = 0;
		
		public function GoogleGeoCode()
		{
			svc.url = URL;
		}
		
		public function fromAddressToLatLon(place:Place):void{
			var params:Object = new Object;
			params["address"] = place.toAddressString();
			params["sensor"] = true;
			
			svc.addEventListener(ResultEvent.RESULT, processGeoCode);
			svc.send(params);
			
		}
		
		protected function processGeoCode(event:ResultEvent):void
		{
			var resultEvent:GeoResultEvent = new GeoResultEvent("geoCodeResult");
			resultEvent.result = convertGoogleObjectToPlace(event.result.GeocodeResponse);
			resultEvent.placeid = placeid;
			dispatchEvent(resultEvent);
			
		}
		
		public function fromLatLonToAddress(lat:Number, lon:Number):void{
			var params:Object = new Object;
			params["latlng"] = lat + "," + lon;
			params["sensor"] = true;	
			
			svc.addEventListener(ResultEvent.RESULT, processReverseGeoCode);
			svc.send(params);
		}
		
		protected function processReverseGeoCode(event:ResultEvent):void
		{
			var resultEvent:GeoResultEvent = new GeoResultEvent("reverseGeoCodeResult");
			resultEvent.result = convertGoogleObjectToPlace(event.result.GeocodeResponse);
			resultEvent.placeid = placeid;
			dispatchEvent(resultEvent);
		}
		
		
		public function getAlternativeLocations(place:Place):void{
			var result:ArrayCollection = new ArrayCollection();
			var altPlace:Place;
			
			var addressArray:Array = place.address.split(" ");
			var streetNumbersPart:String = addressArray.shift();
			var streetRoutePart:String = addressArray.join(" ");
			
			if (streetNumbersPart.indexOf('-') > 0){
				var numberArray:Array = streetNumbersPart.split("-");
				var start:int = parseInt(numberArray[0]);
				var end:int = parseInt(numberArray[1]);
				
				for (var i:int=start; i <=end; i++){
					altPlace = new Place();
					altPlace.address = i + " " + streetRoutePart;
					altPlace.city = place.city;
					altPlace.state= place.state;
					altPlace.mailingCode = place.mailingCode;
					altPlace.country = place.country;
					result.addItem(altPlace);
				}
				
				
			}
			else{
				result.addItem(place);
			}
				
			var resultEvent:GeoResultEvent = new GeoResultEvent("alternativesResult");
			resultEvent.result = result;
			resultEvent.placeid = placeid;
			dispatchEvent(resultEvent);
		}
		
		
		private function convertGoogleObjectToPlace(geoCodeResponse:Object):Place
		{
			var result:Object = new Object();
			var place:Place = new Place();
			var addressAC:ArrayCollection;
			
			var eventResult:Object;
			
			if (geoCodeResponse.result is ArrayCollection){
				eventResult = geoCodeResponse.result[0];
			}
			else if (geoCodeResponse.result){
				eventResult = geoCodeResponse.result;
			}
			else{
				eventResult = new Object();
				eventResult.address_component = new ArrayCollection();
				
			}
			
			
			addressAC = eventResult.address_component;
			
			
			for (var index:Object in addressAC){
				var addresspart:Object = addressAC[index];
				
				if (addresspart.type && addresspart.type is ArrayCollection && addresspart.type[0] == "locality"){
					result.city = addresspart.long_name;
					continue;
				}
				
				if (addresspart.type && addresspart.type is ArrayCollection && addresspart.type[0] == "administrative_area_level_1"){
					result.state = addresspart.short_name;
					continue;
				}
				
				if (addresspart.type && addresspart.type is ArrayCollection && addresspart.type[0] == "country"){
					result.country = addresspart.long_name;
					continue;
				}
				
				if (addresspart.type && addresspart.type is String && addresspart.type == "postal_code"){
					result.mailingCode = addresspart.long_name;
					continue;
				}
				
				if (addresspart.type && addresspart.type is String && addresspart.type == "route"){
					result.streetName = addresspart.long_name;
					continue;
				}
				
				if (addresspart.type && addresspart.type is String && addresspart.type == "street_number"){
					result.streetNumber = addresspart.long_name;
					continue;
				}
				
			}
			
			result.address = result.streetNumber + " " + result.streetName;
			
			place.address = result.address;
			place.city = result.city;
			place.state = result.state;
			place.mailingCode = result.mailingCode;
			place.country = result.country;
			if (eventResult.geometry){
				place.lat = eventResult.geometry.location.lat;
				place.lon = eventResult.geometry.location.lng;
			}
			
			if (!place.city){
				place.city = "Unknown Location";	
			}
			
			return place;
		}
		
	}
	
	
}