package com.terrenceryan.finicky.geo
{
	import com.esri.ags.SpatialReference;
	import com.esri.ags.events.LocatorEvent;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.geometry.WebMercatorMapPoint;
	import com.esri.ags.tasks.Locator;
	import com.esri.ags.tasks.supportClasses.AddressCandidate;
	import com.terrenceryan.finicky.vo.Place;
	
	import events.GeoResultEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.sensors.Geolocation;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	import spark.collections.Sort;
	
	[Event(name="result", type="events.GeoResultEvent")]
	[Event(name="alternativesResult", type="events.GeoResultEvent")]
	
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
		
		public function getAlternativeLocations(place:Place):void{
			var addressToSend:Object = { SingleLine: place.toAddressString() };
			locatorService.outSpatialReference = wgs;
			locatorService.addEventListener(LocatorEvent.ADDRESS_TO_LOCATIONS_COMPLETE,processAlternatives);
			locatorService.addressToLocations(addressToSend,["*"]);
			
		}
		
		protected function processAlternatives(event:LocatorEvent):void
		{
			var ac:ArrayCollection = new ArrayCollection();
			var eventToReport:GeoResultEvent = new GeoResultEvent("alternativesResult");
			
			for (var i:int = 0; i < event.addressCandidates.length; i++){
				var candidate:AddressCandidate = event.addressCandidates[i] as AddressCandidate;
				
				if (candidate.score >= 70){
					var place:Place = convertAddressCandidateToPlace(candidate);
					ac.addItem(place);
				}
			
			}
			
			eventToReport.result = ac;
			dispatchEvent(eventToReport);
		}
		
		private function convertAddressCandidateToPlace(addressCandidate:AddressCandidate):Place{
			var place:Place = new Place();
			
			if (addressCandidate.attributes.House && addressCandidate.attributes.House.length > 0){
				place.address = addressCandidate.attributes.House;
			}
			else{
				place.address = addressCandidate.attributes.FromAddr;
				place.address = place.address + " - ";
				place.address = place.address + addressCandidate.attributes.ToAddr;
			}
			place.address = place.address + " ";
			place.address = place.address + addressCandidate.attributes.StreetName;
			place.address = place.address + " ";
			place.address = place.address + addressCandidate.attributes.SufType;
			
			place.state = addressCandidate.attributes.State;
			place.mailingCode = addressCandidate.attributes.Zip;
			
			place.lat = addressCandidate.attributes.X;
			place.lon = addressCandidate.attributes.Y;
			
			return place;
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