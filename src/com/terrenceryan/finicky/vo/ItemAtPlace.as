package com.terrenceryan.finicky.vo
{
	public class ItemAtPlace
	{
		
		public var item:Item;
		public var place:Place;
		public var notes:String;
		public var date:Date;
		[Bindable]
		public var picturepath:String;
		
		
		public function ItemAtPlace()
		{
		}
	}
}