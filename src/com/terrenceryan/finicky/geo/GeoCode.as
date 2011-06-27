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
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	import spark.collections.Sort;
	
	[Event(name="result", type="events.GeoResultEvent")]
	
	public class GeoCode extends EventDispatcher
	{
		private const NA_URL:String = "http://tasks.arcgisonline.com/ArcGIS/rest/services/Locators/TA_Address_NA_10/GeocodeServer";
		private const EU_URL:String = "http://tasks.arcgisonline.com/ArcGIS/rest/services/Locators/TA_Address_EU/GeocodeServer";
		
		private var locatorService:Locator = new Locator();
		private var wgs:SpatialReference = new SpatialReference(4326);
		public var placeid:int = 0;
		
		
		public function GeoCode()
		{
			locatorService.url = NA_URL;
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
				if (candidate.address.State){
					location.state = candidate.address.State;
				}
				
				if (candidate.address.Zip){
					location.mailingCode = candidate.address.Zip;
				}
				
				if (candidate.address.Postcode){
					location.mailingCode = candidate.address.Postcode;
				}
				
				location.country = "USA";
			}
			else{
				var canAC:ArrayCollection = new ArrayCollection(event.addressCandidates);
				var sort:Sort = new Sort();
				sort.compareFunction = scoreOrder;
				canAC.sort = sort;
				
				canAC.refresh();
				
				
				
				candidate = canAC.getItemAt(0) as AddressCandidate;
			}
			
			location.lon = candidate.location.x;
			location.lat = candidate.location.y;
			
			
			eventToReport.result = location;
			eventToReport.placeid = placeid;
			dispatchEvent(eventToReport);
			
		}
		
		private function scoreOrder(a:Object, b:Object, fields:Array = null):int
			{
				var result:int = 0;
				
				if (a.score > b.score){
					result = -1	
				}
				else if (a.score == b.score){
					result = 0;
				}
				else{
					result = 1;
				}
				
				return result;
			}
	}
}