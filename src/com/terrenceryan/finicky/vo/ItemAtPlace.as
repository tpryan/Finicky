package com.terrenceryan.finicky.vo
{
	public class ItemAtPlace
	{
		[Bindable]
		public var item:Item;
		[Bindable]
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