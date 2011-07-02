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
		
		[Embed(source='/assets/icons/radioCheckOn.png')]
		private static var radioOn:Class;
		
		[Embed(source='/assets/icons/radioCheckOff.png')]
		private static var radioOff:Class;
		
		
		public var bg:Image = new Image();
		public var decoratorCover:Image = new Image();
		public var radio:Image = new Image();
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
			
			
			radio.source = radioOff;
			radio.height = 70;
			radio.width = 65;
			radio.visible = false;
			addChildAt(radio,0);
			
			bg.source = highlightClass;
			bg.width = highlightHeight;
			bg.height = highlightWidth;
			bg.y = 0;
			bg.visible = false;
			addChildAt(bg, 0);
			
			
			
			
			
			
			this.addEventListener(MouseEvent.CLICK, toggleHighlight);
			
			
		}
		
		
		
		protected function toggleHighlight(event:MouseEvent):void
		{
			if (!bg.visible){
				decoratorCover.visible = true;
				radio.source = radioOn;
			}
			else{
				decoratorCover.visible = false;
				radio.source = radioOff;
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
			labelDisplay.wordWrap = true;
			
			if (!(labelDisplay.text == "[Add location by hand]")){
				decoratorCover.visible = false;
				decoratorDisplay.visible = false;
				radio.visible = true;
				setElementPosition(radio, 10, 5);
			}
			setElementPosition(labelDisplay, 80, labelDisplay.y);
			setElementPosition(messageDisplay, 80, messageDisplay.y);
			
			
			height = 81;
			
		}
	}
}