package com.terrenceryan.finicky.geo
{
	import com.esri.ags.SpatialReference;
	import com.esri.ags.events.LocatorEvent;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.geometry.WebMercatorMapPoint;
	import com.esri.ags.tasks.Locator;
	import com.esri.ags.tasks.supportClasses.AddressCandidate;
	import com.terrenceryan.finicky.util.StringUtil;
	import com.terrenceryan.finicky.vo.Place;
	
	import events.GeoResultEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.sensors.Geolocation;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	import spark.collections.Sort;
	
	[Event(name="result", type="events.GeoResultEvent")]
	[Event(name="fault", type="flash.events.Event")]
	[Event(name="alternativesResult", type="events.GeoResultEvent")]
	
	public class GeoCode extends EventDispatcher
	{
		private const NA_URL:String = "http://tasks.arcgisonline.com/ArcGIS/rest/services/Locators/TA_Streets_US/GeocodeServer";
		private const EU_URL:String = "http://tasks.arcgisonline.com/ArcGIS/rest/services/Locators/TA_Address_EU/GeocodeServer";
		
		private var locatorService:Locator = new Locator();
		private var wgs:SpatialReference = new SpatialReference(4326);
		public var placeid:int = 0;
		private var stringUtil:StringUtil = new StringUtil();
		private var mappoint:MapPoint;
		
		public function GeoCode()
		{
			locatorService.url = NA_URL;
			locatorService.concurrency = "last";
		
		}
		
		public function fromAddressToLatLon(place:Place):void{
			var addressToSend:Object = new Object();
			addressToSend.Street = place.address;
			addressToSend.City = place.city;
			addressToSend.State = place.state;
			addressToSend.ZIP = place.mailingCode;
			locatorService.outSpatialReference = wgs;
			locatorService.addEventListener(LocatorEvent.ADDRESS_TO_LOCATIONS_COMPLETE,getLocation);
			locatorService.addEventListener(FaultEvent.FAULT, handleFault);
		 	locatorService.addressToLocations(addressToSend,["*"]);
			
		}
		
		public function getAlternativeLocations(place:Place):void{
			var addressToSend:Object = new Object();
			addressToSend.Street = place.address;
			addressToSend.City = place.city;
			addressToSend.State = place.state;
			addressToSend.ZIP = place.mailingCode;
			
			locatorService.outSpatialReference = wgs;
			locatorService.addEventListener(LocatorEvent.ADDRESS_TO_LOCATIONS_COMPLETE,processAlternatives);
			locatorService.addEventListener(FaultEvent.FAULT, handleFault);
			locatorService.addressToLocations(addressToSend,["*"]);
			
		}
		
		protected function handleFault(event:FaultEvent):void
		{
			trace("geoCode.getAlternativeLocations Error");
			
		}
		
		protected function processAlternatives(event:LocatorEvent):void
		{
			var ac:ArrayCollection = new ArrayCollection();
			var eventToReport:GeoResultEvent = new GeoResultEvent("alternativesResult");
			
			for (var i:int = 0; i < event.addressCandidates.length; i++){
				var candidate:AddressCandidate = event.addressCandidates[i] as AddressCandidate;
				
				if (candidate.score >= 0){
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
			else if (addressCandidate.attributes.LeftFrom){
				place.address = addressCandidate.address.toString().split(" ")[0];
			}
			else if (addressCandidate.address is String){
				place.address = addressCandidate.attributes.LeftFrom;
			}
			else{
				place.address = addressCandidate.attributes.FromAddr;
				place.address = place.address + " - ";
				place.address = place.address + addressCandidate.attributes.ToAddr;
			}
			if (addressCandidate.attributes.PreType){
				place.address = place.address + " ";
				place.address = place.address + addressCandidate.attributes.PreType;
			}
			
			
			
			place.address = place.address + " ";
			place.address = place.address + addressCandidate.attributes.StreetName;
			place.address = place.address + " ";
			
			
			if (addressCandidate.attributes.SufType){
				place.address = place.address + addressCandidate.attributes.SufType;
			}
			else if(addressCandidate.attributes.StreetType){
				place.address = place.address + addressCandidate.attributes.StreetType;
			}
			
			
			if (addressCandidate.attributes.City){
				place.city = addressCandidate.attributes.City;
			}
			else if(addressCandidate.attributes.LeftCity){
				place.city = addressCandidate.attributes.LeftCity;
			}
			
			if (addressCandidate.attributes.State){
				place.state = addressCandidate.attributes.State;
			}
			else if(addressCandidate.attributes.LeftState){
				place.state = addressCandidate.attributes.LeftState;
			}
			
			if (addressCandidate.attributes.ZIP){
				place.mailingCode = addressCandidate.attributes.ZIP;
			}
			else if(addressCandidate.attributes.LeftZIP){
				place.mailingCode = addressCandidate.attributes.LeftZIP;
			}
			
			place.lat = addressCandidate.attributes.X;
			place.lon = addressCandidate.attributes.Y;
			
			
			//correcting for tendency to over cap addresses
			place.address = stringUtil.toTitleCase(place.address);
				
			
			return place;
		}
		
		public function fromLatLonToAddress(lat:Number,lon:Number):void{
			trace("ESRI Calls started");
			mappoint = new MapPoint(lon,lat,wgs);
			locatorService.outSpatialReference = wgs;
			locatorService.addEventListener(LocatorEvent.LOCATION_TO_ADDRESS_COMPLETE,getLocation);
			locatorService.addEventListener(FaultEvent.FAULT, faultHandler);
			locatorService.locationToAddress(mappoint,1000);
			
		}
		
		
		
		protected function faultHandler(event:FaultEvent):void
		{
			trace(event.fault.faultString);
			dispatchEvent( new Event("fault"));
			/*if (locatorService.url == NA_URL){
				locatorService.url = EU_URL;
				locatorService.locationToAddress(mappoint,1000);
			}*/
			
		}		
		
		protected function getLocation(event:LocatorEvent):void
		{
			trace("got result");
			var eventToReport:GeoResultEvent = new GeoResultEvent("result");
			var location:Object = new Object();
			
			var candidate:AddressCandidate = new AddressCandidate();
			
			if (!event.addressCandidates){
				candidate = event.addressCandidate;
				
				if(candidate.address.Street){
					location.address = candidate.address.Street;
				}
				else{
					location.address = candidate.address.Address;
				}
				
				location.city = candidate.address.City;
				if (candidate.address.State){
					location.state = candidate.address.State;
				}
				
				if (candidate.address.ZIP){
					location.mailingCode = candidate.address.ZIP;
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