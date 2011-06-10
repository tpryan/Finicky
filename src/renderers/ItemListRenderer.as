package renderers
{
	
	
	import flash.events.MouseEvent;
	
	import spark.components.IconItemRenderer;
	import spark.components.Image;
	
	public class ItemListRenderer extends IconItemRenderer
	{
		
		private var _bgVisible:Boolean = false;
		
		[Embed(source='/assets/bg/bg_itemSelected.png')]
		private static var itemSelected:Class;	
		
		[Embed(source='/assets/icons/itemListButtonDown.png')]
		private static var itemDown:Class;
		
		[Embed(source='/assets/bg/rule.png')]
		private static var rule:Class;
		
		[Embed(source='/assets/bg/rule2.png')]
		private static var rule2:Class;
		
		[Embed(source='/assets/bg/rule3.png')]
		private static var rule3:Class;
		
		public var bg:Image = new Image();
		public var decoratorCover:Image = new Image();
		public var ruleImg:Image = new Image();
		
		public function ItemListRenderer()
		{
			super();
			
			
			
			decoratorCover.source= itemDown;
			decoratorCover.width = 123;
			decoratorCover.height = 125;
			decoratorCover.visible = false;
			addChildAt(decoratorCover, 0);
			
			
			bg.source = itemSelected;
			bg.width = 585;
			bg.height = 150;
			bg.y = 18;
			bg.visible = false;
			addChildAt(bg, 0);
			
			
			
			
			ruleImg.source = rule;
			addChildAt(ruleImg,0);
			
			
			this.addEventListener(MouseEvent.CLICK, toggleHighlight);
			
			
		}
		
		
		
		protected function toggleHighlight(event:MouseEvent):void
		{
			if (!bg.visible){
				bg.visible = true;
				decoratorCover.visible = true;
			}
			else{
				bg.visible = false;
				decoratorCover.visible = false;
			}
			
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
		
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			setElementPosition(decoratorCover, decoratorDisplay.x, decoratorDisplay.y);
			setElementSize(ruleImg, width, 2);
			setElementPosition(ruleImg, 0,0);
			
			var ruleNumber:Number = labelDisplay.text.length % 3;
			
			switch(ruleNumber)
			{
				case 1:
				{
					ruleImg.source = rule2;
					break;
				}
				case 2:
				{
					ruleImg.source = rule3;
					break;
				}
					
				default:
				{
					ruleImg.source = rule;
					break;
				}
			}
			
			
		}
	}
}