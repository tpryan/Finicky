package skins
{
	import mx.events.FlexEvent;
	
	import spark.skins.mobile.ButtonSkin;
	
	public class EditLocationButtonSkin extends ButtonSkin
	{
		
		[Bindable]
		[Embed(source="/assets/icons/editLocationDown.png")]
		private var down:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/editLocationUp.png")]
		private var up:Class;
		
		public function EditLocationButtonSkin()
		{
			super();
			width = 383;
			height = 158;
		}
		
		
		override protected function labelDisplay_valueCommitHandler(event:FlexEvent):void 
		{
			super.labelDisplay_valueCommitHandler(event);
			
			labelDisplayShadow.text = labelDisplay.text;
			
			
			labelDisplay.setStyle("fontFamily","Lions Den");
			labelDisplay.setStyle("fontSize",30);
			labelDisplay.setStyle("fontWeight","normal");
			labelDisplay.setStyle("color",0x48250A);
			labelDisplayShadow.setStyle("fontFamily","Lions Den");
			labelDisplayShadow.setStyle("fontSize",30);
			labelDisplayShadow.setStyle("fontWeight","normal");
			
			
		}

		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			
		}
		
		override protected function getBorderClassForCurrentState():Class
		{
			
			if (currentState == "down"){
				labelDisplay.setStyle("color",0xFFFFFF);
				return down;
			}
			else{
				labelDisplay.setStyle("color",0x48250A);
				return up;
			}	
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			setElementPosition(labelDisplay, 40, 55);
			setElementPosition(labelDisplayShadow, labelDisplay.x, labelDisplay.y + 1);
		}
		
	}
}