package skins
{
	
	import spark.components.Image;
	import spark.skins.mobile.TextInputSkin;
	
	public class EditTexInputSkin extends TextInputSkin
	{
		
		
		[Bindable]
		[Embed(source="/assets/bg/bg_editField.png")]
		protected var borderClassTemp:Class;
		
		[Bindable]
		[Embed(source="/assets/bg/bg_whitebrush.png")]
		protected var whitebrush:Class;
		
		protected var whiteBG:Image = new Image;
		
		public function EditTexInputSkin()
		{
			super();
			borderClass = borderClassTemp;
			//width = 552;
			height = 120;
			
			
			
			
			
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			border.blendMode = "multiply";
		}
		
		override protected function layoutContents(unscaledWidth:Number, 
												   unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			whiteBG.source = whitebrush;
			whiteBG.percentWidth = 100;
			whiteBG.preliminaryHeight = 100;
			addChildAt(whiteBG,0);
			setElementPosition(whiteBG, 0, 0);
			
			textDisplay.setStyle("fontFamily", "Lions Den");
			textDisplay.setStyle("fontSize", 36);
			textDisplay.setStyle("color", 0x22221b);
			textDisplay.setStyle("textAlign", "center");
			
			
			
		}
	}
}