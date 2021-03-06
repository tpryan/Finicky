package com.terrenceryan.finicky
{
	import com.terrenceryan.finicky.db.DBManager;
	import com.terrenceryan.finicky.geo.GoogleGeoCode;
	import com.terrenceryan.finicky.vo.Place;
	
	import com.terrenceryan.finicky.geo.GeoResultEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="reconciled", type="flash.events.Event")]

	public class LocationReconciler extends EventDispatcher
	{
		
		protected var dbManager:DBManager;
		protected var places:ArrayCollection;
		
		
		public function LocationReconciler()
		{
			var dbFile:File = File.applicationDirectory.resolvePath("finicky.db");
			dbManager = new DBManager(dbFile);
			
		}
		
		public function reconcile():void{
			places = dbManager.placeDAO.listWithNoLocation();
			
			for (var i:int; i < places.length; i++){
				var place:Place = places.getItemAt(i) as Place;
				trace("Looking up  "+ place.name + " lat: " + place.lat + " lon: "+ place.lon);
				var geoCode:GoogleGeoCode = new GoogleGeoCode();
				geoCode.placeid = place.placeid;
				geoCode.addEventListener("geoCodeResult", processResult);
				geoCode.fromAddressToLatLon(place);
			}
			
		}
		
		protected function processResult(event:GeoResultEvent):void
		{
			var place:Place = dbManager.placeDAO.get(event.placeid);
			place.lat = event.result.lat;
			place.lon = event.result.lon;
			dbManager.placeDAO.save(place);
			trace("Processed  "+ place.name + " lat: " + place.lat + " lon: "+ place.lon);
			dispatchEvent(new Event("reconciled") );
			
		}
		
	}
}