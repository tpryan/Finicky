package renderers
{
	
	
	import spark.components.IconItemRenderer;
	import spark.components.Image;
	
	public class NoBackGround extends IconItemRenderer
	{
		
		private var _bgVisible:Boolean = false;
		
		[Embed(source='/assets/bg/bg_itemSelected.png')]
		private static var itemSelected:Class;	
		
		
		public var bg:Image = new Image();
		
		
		public function NoBackGround()
		{
			super();
			
			bg.source = itemSelected;
			bg.width = 585;
			bg.height = 150;
			bg.y = 18;
			bg.visible = false;
			addChildAt(bg, 0);
			
			
		}
		
		[Bindable]
		public function get bgVisible():Boolean
		{
			return _bgVisible;
		}

		public function set bgVisible(value:Boolean):void
		{
			bg.visible = value;
			_bgVisible = value;
		}

		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			
		}
		
		
		
	}
}