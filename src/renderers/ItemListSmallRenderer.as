package renderers
{
	
	
	import flash.events.MouseEvent;
	
	import spark.components.IconItemRenderer;
	import spark.components.Image;
	
	public class ItemListSmallRenderer extends IconItemRenderer
	{
		
		private var _bgVisible:Boolean = false;
		
		
		[Embed(source='/assets/bg/bg_itemSelectedSmaller.png')]
		private static var itemSelectedSmall:Class;	
		
		[Embed(source='/assets/icons/itemListButtonSmallDown.png')]
		private static var itemDownSmall:Class;
		
		[Embed(source='/assets/icons/itemListButtonSmallUp.png')]
		private static var itemUpSmall:Class;
		
		[Embed(source='/assets/bg/rule.png')]
		private static var rule:Class;
		
		[Embed(source='/assets/bg/rule2.png')]
		private static var rule2:Class;
		
		[Embed(source='/assets/bg/rule3.png')]
		private static var rule3:Class;
		
		public var bg:Image = new Image();
		public var decoratorCover:Image = new Image();
		public var ruleImg:Image = new Image();
		public var size:String;
		
		
		protected var decoratorClass:Class;
		protected var decoratorCoverClass:Class;
		protected var decoratorWidth:int;
		protected var decoratorHeight:int;
		
		protected var highlightClass:Class;
		protected var highlightWidth:int;
		protected var highlightHeight:int;
		
		
		public function ItemListSmallRenderer()
		{
			super();
			
			decoratorClass = itemUpSmall
			decoratorCoverClass = itemDownSmall;
			decoratorHeight = 61;
			decoratorWidth = 60;
			
			highlightClass = itemSelectedSmall;
			highlightHeight = 585;
			highlightWidth = 75;
			
			
			decoratorCover.source= decoratorCoverClass;
			decoratorCover.width = decoratorWidth;
			decoratorCover.height = decoratorHeight;
			decoratorCover.visible = false;
			addChildAt(decoratorCover, 0);
			
			
			bg.source = highlightClass;
			bg.width = highlightHeight;
			bg.height = highlightWidth;
			bg.y = 0;
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
			
			decoratorDisplay.source = decoratorClass;
			setElementSize(decoratorDisplay, decoratorWidth, decoratorHeight);
			
			setElementPosition(decoratorCover, decoratorDisplay.x, decoratorDisplay.y);
			setElementSize(ruleImg, width, 2);
			setElementPosition(ruleImg, 0,0);
			labelDisplay.wordWrap = true;
			
			
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