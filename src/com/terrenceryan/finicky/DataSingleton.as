package com.terrenceryan.finicky
{
	import com.terrenceryan.finicky.db.DBManager;
	import com.terrenceryan.finicky.geo.GeoCode;
	import com.terrenceryan.finicky.vo.Item;
	import com.terrenceryan.finicky.vo.ItemAtPlace;
	import com.terrenceryan.finicky.vo.Place;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.sensors.Geolocation;
	
	import mx.collections.ArrayCollection;
	
	public class DataSingleton extends EventDispatcher
	{
		[Bindable]
		public var home:Place;
		[Bindable]
		public var homeAlternatives:ArrayCollection;
		public var dbManager:DBManager;
		public var geo:Geolocation;
		public var geoCodeService:GeoCode;
		public var os:String;
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
	}
}