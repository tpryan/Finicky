package com.terrenceryan.finicky.geo
{
	import com.esri.ags.SpatialReference;
	import com.esri.ags.events.LocatorEvent;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.geometry.WebMercatorMapPoint;
	import com.esri.ags.tasks.Locator;
	import com.esri.ags.tasks.supportClasses.AddressCandidate;
	
	import events.GeoResultEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.sensors.Geolocation;
	
	import mx.rpc.events.FaultEvent;
	
	
	[Event(name="result", type="events.GeoResultEvent")]

	public class GeoCode extends EventDispatcher
	{
		
		
		private var locatorService:Locator = new Locator();
		private var wgs:SpatialReference = new SpatialReference(4326);
		
		
		public function GeoCode()
		{
			locatorService.url = "http://tasks.arcgisonline.com/ArcGIS/rest/services/Locators/TA_Address_NA_10/GeocodeServer";
			locatorService.concurrency = "last";
		
		}
		
		public function fromAddressToLatLon(address:String):void{
			var addressToSend:Object = { SingleLine: address };
			locatorService.outSpatialReference = wgs;
			locatorService.addEventListener(LocatorEvent.ADDRESS_TO_LOCATIONS_COMPLETE,getLocation);
		 	locatorService.addressToLocations(addressToSend,["*"]);
			
		}
		
		public function fromLatLonToAddress(lat:Number,lon:Number):void{
			
			var mappoint:MapPoint = new MapPoint(lon,lat,wgs);
			
			locatorService.outSpatialReference = wgs;
			locatorService.addEventListener(LocatorEvent.LOCATION_TO_ADDRESS_COMPLETE,getLocation);
			locatorService.addEventListener(FaultEvent.FAULT, faultHandler);
			locatorService.locationToAddress(mappoint,100);
			
		}
		
		protected function faultHandler(event:FaultEvent):void
		{
			trace(event.fault.content);
			
		}		
		
		protected function getLocation(event:LocatorEvent):void
		{
			trace("got result");
			var eventToReport:GeoResultEvent = new GeoResultEvent("result");
			var location:Object = new Object();
			
			var candidate:AddressCandidate = new AddressCandidate();
			
			if (!event.addressCandidates){
				candidate = event.addressCandidate;
				location.address = candidate.address.Address;
				location.city = candidate.address.City;
				location.state = candidate.address.State;
				location.mailingCode = candidate.address.Zip;
				location.country = "USA";
			}
			else{
				candidate = event.addressCandidates[0];
			}
			
			location.lon = candidate.location.x;
			location.lat = candidate.location.y;
			
			
			eventToReport.result = location;
			dispatchEvent(eventToReport);
			
		}
	}
}