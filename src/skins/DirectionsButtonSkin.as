package skins
{
	import mx.events.FlexEvent;
	
	import spark.components.Image;
	import spark.skins.mobile.ButtonSkin;
	
	public class DirectionsButtonSkin extends ButtonSkin
	{
	
		protected var hl:Image = new Image();
		
		[Bindable]
		[Embed(source="/assets/icons/directionsUp.png")]
		private var up:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/directionsHighlight.png")]
		private var highlight:Class;
		
		public function DirectionsButtonSkin()
		{
			super();
			
			if (applicationDPI == 160){
				width = 100;
				height = 78;
				hl.width = 100;
				hl.height = 78;
			}
			else{
				width = 200;
				height = 147;
				hl.width = 200;
				hl.height = 147;
			}
			
			
			
			
			hl.source = highlight;
			
			hl.x = 0;
			hl.y = 0;
			hl.visible = false;
			addChild(hl);
		}
		
		override protected function labelDisplay_valueCommitHandler(event:FlexEvent):void 
		{
			var fontSize:int = 20;
			if (applicationDPI == 160){
				fontSize= 10;
			}
			
			super.labelDisplay_valueCommitHandler(event);
			labelDisplayShadow.text = labelDisplay.text;
			
			labelDisplay.setStyle("fontFamily","Lions Den");
			labelDisplay.setStyle("fontSize",fontSize);
			labelDisplay.setStyle("fontWeight","normal");
			labelDisplay.setStyle("color",0x48250A);
			labelDisplayShadow.setStyle("fontFamily","Lions Den");
			labelDisplayShadow.setStyle("fontSize",fontSize);
			labelDisplayShadow.setStyle("fontWeight","normal");
			
			
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			
		}
		
		override protected function getBorderClassForCurrentState():Class
		{
			if (currentState == "down"){
				labelDisplay.setStyle("color",0xFFFFFF);
				hl.visible = true;
			}
			else{
				labelDisplay.setStyle("color",0x48250A);
				hl.visible = false;
			}
			
			return up;
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var ldx:int = 50;
			var ldy:int = 55;
			
			if (applicationDPI == 160){
				ldx = 25;
				ldy = 27;
			}
			
			super.layoutContents(unscaledWidth, unscaledHeight);
			setElementPosition(labelDisplay, ldx, ldy);
			setElementPosition(labelDisplayShadow, labelDisplay.x, labelDisplay.y + 1);
			//border.blendMode = "multiply";	
		}
		
	}
	
	
	
	
}