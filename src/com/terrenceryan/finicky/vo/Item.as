package com.terrenceryan.finicky.vo
{
	public class Item
	{
		
		private var _itemid:int = 0;
		private var _name:String = null;
		private var _description:String = null;
		
		public function Item()
		{
		}

		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get itemid():int
		{
			return _itemid;
		}

		public function set itemid(value:int):void
		{
			_itemid = value;
		}

	}
}