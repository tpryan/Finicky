package renderers
{
	
	
	import flash.events.MouseEvent;
	
	import spark.components.Group;
	import spark.components.IconItemRenderer;
	import spark.components.Image;
	import spark.primitives.BitmapImage;
	
	public class ItemListRenderer extends IconItemRenderer
	{
		
		private var _bgVisible:Boolean = false;
		
		[Embed(source='/assets/bg/bg_itemSelected.png')]
		private static var itemSelected:Class;
		
		[Embed(source='/assets/icons/itemListButtonDown.png')]
		private static var itemDown:Class;
		
		[Embed(source='/assets/icons/itemListButtonUp.png')]
		private static var itemUp:Class;
		
		[Embed(source='/assets/bg/bg_itemSelected160.png')]
		private static var itemSelected160:Class;
		
		[Embed(source='/assets/icons/itemListButtonDown160.png')]
		private static var itemDown160:Class;
		
		[Embed(source='/assets/icons/itemListButtonUp160.png')]
		private static var itemUp160:Class;
		
		
		[Embed(source='/assets/bg/rule.png')]
		private static var rule:Class;
		
		[Embed(source='/assets/bg/rule2.png')]
		private static var rule2:Class;
		
		[Embed(source='/assets/bg/rule3.png')]
		private static var rule3:Class;
		
		public var bgHolder:Group = new Group;
		public var decoratorCoverHolder:Group = new Group;
		public var ruleImgHolder:Group = new Group;
		
		public var bg:BitmapImage = new BitmapImage();
		public var decoratorCover:BitmapImage = new BitmapImage();
		public var ruleImg:BitmapImage = new BitmapImage();
		public var size:String;
		
		
		protected var decoratorClass:Class;
		protected var decoratorCoverClass:Class;
		protected var decoratorWidth:int;
		protected var decoratorHeight:int;
		
		protected var highlightClass:Class;
		protected var highlightWidth:int;
		protected var highlightHeight:int;
		
		protected var decoratorX:int;
		protected var labelDisplayY:int;
		
		
		public function ItemListRenderer()
		{
			super();
			
			
			if (applicationDPI == 160){
				decoratorClass = itemUp160;
				decoratorCoverClass = itemDown160;
				highlightClass = itemSelected160;
				
				
				decoratorHeight = 63;
				decoratorWidth = 61;
				highlightHeight = 243;
				highlightWidth = 75;
				bg.y = 9;
			}
			else{
				decoratorClass = itemUp;
				decoratorCoverClass = itemDown;
				highlightClass = itemSelected;
				
				decoratorHeight = 125;
				decoratorWidth = 123;
				highlightHeight = 585;
				highlightWidth = 150;
				bg.y = 18;
			}
			
		
			
			
			addChildAt(decoratorCoverHolder, 0);
			decoratorCover.source= decoratorCoverClass;
			decoratorCover.width = decoratorWidth;
			decoratorCover.height = decoratorHeight;
			decoratorCover.visible = false;
			decoratorCoverHolder.addElement(decoratorCover);
			
			addChildAt(bgHolder, 0);
			bg.source = highlightClass;
			bg.width = highlightHeight;
			bg.height = highlightWidth;
			
			bg.visible = false;
			bgHolder.addElement(bg);
			
			addChildAt(ruleImgHolder, 0);
			ruleImg.source = rule;
			ruleImgHolder.addElement(ruleImg);
			
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
			
			
			if (applicationDPI == 160){
				decoratorDisplay.source = itemUp160;
				decoratorX = decoratorDisplay.x+ 10;
				height = 65;
				labelDisplayY = 15;
			}
			else{
				decoratorDisplay.source = itemUp;
				decoratorX = decoratorDisplay.x;
				height = 130;
				labelDisplayY = 30;
			}
			
			setElementSize(decoratorDisplay, decoratorWidth, decoratorHeight);
			setElementPosition(bg, bg.x, -20);
			
			setElementPosition(decoratorDisplay, decoratorX, 5);
			setElementPosition(decoratorCover, decoratorDisplay.x, decoratorDisplay.y);
			
			setElementPosition(labelDisplay, labelDisplay.x, labelDisplayY);
			if (messageDisplay){
				setElementPosition(messageDisplay, messageDisplay.x, labelDisplay.y + labelDisplay.height - 5);
			}
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