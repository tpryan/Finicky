package skins
{
	import flash.events.TouchEvent;
	
	import spark.components.Image;
	import spark.skins.mobile.ListSkin;
	
	public class LocationSelectorListSkin extends ListSkin
	{
		
		[Embed(source='/assets/bg/bg_main.jpg')]
		private static var bgClass:Class;	
		
		public var bg:Image = new Image();
	
		
		public function LocationSelectorListSkin()
		{
			super();
			
			
			bg.source = bgClass;
			bg.scaleMode = "stretch";
			addChild(bg);
			
			
		}
		
		protected function resetBGPosition(event:TouchEvent):void
		{
			setElementPosition(bg, dataGroup.x,dataGroup.y);
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			dataGroup.addEventListener(TouchEvent.TOUCH_MOVE, resetBGPosition);
			setElementSize(bg, width, height);
			setElementPosition(bg, dataGroup.x,dataGroup.y);
				
		}
		
		
	}
}