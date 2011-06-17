package skins
{
	import mx.events.FlexEvent;
	
	import spark.components.Image;
	import spark.skins.mobile.ButtonSkin;
	
	public class FilterButtonSkin extends ButtonSkin
	{
		
		
		[Bindable]
		[Embed(source="/assets/icons/filterbuttonUp.png")]
		private var up:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/filterhighlight.png")]
		private var highlight:Class;
		
		protected var hl:Image = new Image();
		
		public function FilterButtonSkin()
		{
			super();
			width = 243;
			height = 103;
			
			hl.source = highlight;
			hl.width = 243;
			hl.height = 103;
			hl.x = 0;
			hl.y = 0;
			hl.visible = false;
			addChild(hl);
		}
		
		
		override protected function labelDisplay_valueCommitHandler(event:FlexEvent):void 
		{
			super.labelDisplay_valueCommitHandler(event);
			labelDisplayShadow.text = labelDisplay.text;
			
			labelDisplay.setStyle("fontFamily","Lions Den");
			labelDisplay.setStyle("fontSize",40);
			labelDisplay.setStyle("fontWeight","normal");
			labelDisplay.setStyle("color",0x48250A);
			labelDisplayShadow.setStyle("fontFamily","Lions Den");
			labelDisplayShadow.setStyle("fontSize",40);
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
			super.layoutContents(unscaledWidth, unscaledHeight);
			//border.blendMode = "multiply";	
		}
		
	}
}