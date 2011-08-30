package com.terrenceryan.finicky
{
	import com.terrenceryan.finicky.db.DBManager;
	import com.terrenceryan.finicky.geo.GoogleGeoCode;
	import com.terrenceryan.finicky.vo.Item;
	import com.terrenceryan.finicky.vo.ItemAtPlace;
	import com.terrenceryan.finicky.vo.Place;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.sensors.Geolocation;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="homeUpdated", type="flash.events.Event")]
	
	public class DataSingleton extends EventDispatcher
	{
		private var _home:Place;
		[Bindable]
		public var homeAlternatives:ArrayCollection;
		public var dbManager:DBManager;
		public var geo:Geolocation;
		public var geoCodeService:GoogleGeoCode;
		public var os:String;
		[Bindable]
		public var softControls:Boolean;
		public var itemAtPlaceList:ArrayCollection;
		public var selectedIndex:int;
		public var navigating:String;
		public var itemAtPlace:ItemAtPlace;
		public var place:Object;
		public var itemName:String;
		public var itemToPlaceInProgress:Boolean;
		public var item:Item;
		public var noticeShown:Boolean;
		public var lastView:String;
		public var allowToClose:Boolean = true;
		public var locationReconciler:LocationReconciler;
		public var placeName:String;
		public var displayNotice:Boolean;
		
		public function DataSingleton()
		{
			super();	
		}

		[Bindable]
		public function get home():Place
		{
			return _home;
		}

		public function set home(value:Place):void
		{
			
			var latDiff:int = 1;
			var lonDiff:int = 1;
			var makeChange:Boolean = true;
			var saveChange:Boolean = true;
			
			
			//new home value has to be as specfic 
			// as old value if nearby.
			if (_home){
				latDiff = Math.abs(value.lat - _home.lat); 
				lonDiff = Math.abs(value.lon - _home.lon); 
			}
			
			if ((latDiff < .005) && (lonDiff < .005) && (value.address.length == 0 )){
				makeChange = false;
			}
			
			if (value.lat == 0 && value.lon == 0){
				saveChange = false;
			}
			
			if (value && (value.lat != 0 || value.lon != 0)){
				saveChange = false;
			}
			
			
			if (makeChange = true){
				if (saveChange){
					dbManager.currentLocationDBO.save(value);
				}
				
				_home = value;
				dispatchEvent(new Event("homeUpdated"));
			
				
			}
			
		}

	}
}