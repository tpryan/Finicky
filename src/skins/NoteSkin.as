package skins
{
	import flash.events.FocusEvent;
	
	import spark.components.Image;
	import spark.skins.mobile.TextAreaSkin;

	
	
	
	public class NoteSkin extends TextAreaSkin
	{
		[Bindable]
		[Embed(source="/assets/bg/bg_blank.png")]
		private var bgClass:Class;
		
		
		
		
		
		public function NoteSkin()
		{
			super();
			
		}
		
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
			var borderSize:uint = (border) ? layoutBorderSize : 0;
			var borderWidth:uint = borderSize * 2;
			
			// Draw the contentBackgroundColor
			//graphics.beginFill(0xC3F4FC, getStyle("contentBackgroundAlpha"));
			//graphics.drawRoundRect(borderSize, borderSize, unscaledWidth - borderWidth, unscaledHeight - borderWidth, layoutCornerEllipseSize, layoutCornerEllipseSize);
			//graphics.endFill();
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void{
			
			super.layoutContents(unscaledWidth, unscaledHeight);
			
			textDisplay.setStyle("fontFamily", "Lions Den");
			textDisplay.setStyle("fontSize", 36);
			textDisplay.setStyle("color", 0x22221b);
			textDisplay.setStyle("paddingLeft",200);
			
			
			
			
			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			if (border)
			{
				removeChild(border);
				border = new bgClass;
				addChild(border);
			}
			
			
			
		}
		
		protected function drawBGRect(event:FocusEvent):void
		{
			var borderSize:uint = (border) ? layoutBorderSize : 0;
			var borderWidth:uint = borderSize * 2;
			
			graphics.beginFill(0xC3F4FC, getStyle("contentBackgroundAlpha"));
			graphics.drawRoundRect(textDisplay.x+10, textDisplay.y-18, textDisplay.width-25, textDisplay.height+18, layoutCornerEllipseSize, layoutCornerEllipseSize);
			graphics.endFill();
			
		}	
		
		protected function removeBGRect(event:FocusEvent):void
		{
			
			graphics.clear();
			
		}	
		
	}
}