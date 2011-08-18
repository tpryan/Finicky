package skins
{
	
	import flash.events.FocusEvent;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.supportClasses.StyleableTextField;
	import spark.primitives.BitmapImage;
	import spark.skins.mobile.TextInputSkin;
	
	public class SuggestionTextBoxTextInputSkin extends TextInputSkin
	{
		
		
		[Bindable]
		[Embed(source="/assets/bg/bg_editField.png")]
		protected var borderClassTemp:Class;
		
		[Bindable]
		[Embed(source="/assets/bg/bg_whitebrush.png")]
		protected var whitebrush:Class;
		
		protected var whiteBG:BitmapImage = new BitmapImage();
		protected var whiteBGHolder:Group = new Group();
		
		public function SuggestionTextBoxTextInputSkin()
		{
			super();
			borderClass = borderClassTemp;
			height = 90;
			this.cacheAsBitmap = true;			
			
		}
		
		
		
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			border.blendMode = "multiply";
		}
		
		override protected function layoutContents(unscaledWidth:Number, 
												   unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			whiteBG.source = whitebrush;
			
			addChildAt(whiteBGHolder,0);
			whiteBGHolder.addElement(whiteBG);
			
			setElementPosition(whiteBGHolder, 0, 0);
			setElementSize(whiteBG, border.width,border.height);
			
			textDisplay.setStyle("fontFamily", "Lions Den");
			textDisplay.setStyle("fontSize", 36);
			textDisplay.setStyle("color", 0x22221b);
			
			
			
			if (hostComponent.getStyle("textAlign")){
				textDisplay.setStyle("textAlign", hostComponent.getStyle("textAlign"));
			}
			else{
				textDisplay.setStyle("textAlign", "center");
				if (promptDisplay){
					promptDisplay.setStyle("textAlign", "center");
				}
			}
			
			
			
			textDisplay.addEventListener(FocusEvent.FOCUS_IN, drawBGRect);
			textDisplay.addEventListener(FocusEvent.FOCUS_OUT, removeBGRect);
			
		}
		
		protected function drawBGRect(event:FocusEvent):void
		{
			/*var borderSize:uint = (border) ? layoutBorderSize : 0;
			var borderWidth:uint = borderSize * 2;
			
			// Draw the contentBackgroundColor
			graphics.beginFill(0xC3F4FC, getStyle("contentBackgroundAlpha"));
			graphics.drawRoundRect(textDisplay.x, textDisplay.y-14, textDisplay.width-25, textDisplay.height+15, layoutCornerEllipseSize, layoutCornerEllipseSize);
			graphics.endFill();*/
			
		}	
		
		protected function removeBGRect(event:FocusEvent):void
		{
			
			// Draw the contentBackgroundColor
			graphics.clear();
			
		}
		
		override protected function createPromptDisplay():StyleableTextField
		{
			var prompt:StyleableTextField = StyleableTextField(createInFontContext(StyleableTextField));
			prompt.styleName = this;
			prompt.editable = false;
			prompt.mouseEnabled = false;
			
			prompt.setStyle("fontFamily", "Lions Den");
			prompt.setStyle("fontSize", 36);
			prompt.setStyle("color", 0x999999);
			
			
			return prompt;
		}
		
		
		
	}
}