package com.terrenceryan.finicky
{
	import com.terrenceryan.finicky.db.DBManager;
	import com.terrenceryan.finicky.geo.GeoCode;
	import com.terrenceryan.finicky.vo.Place;
	
	import events.GeoResultEvent;
	
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	public class LocationReconciler
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
				var geoCode:GeoCode = new GeoCode();
				geoCode.placeid = place.placeid;
				geoCode.addEventListener("result", processResult);
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
			
		}
		
	}
}