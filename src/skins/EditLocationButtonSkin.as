package skins
{
	import flash.display.DisplayObject;
	
	import mx.events.FlexEvent;
	
	import spark.components.Image;
	import spark.skins.mobile.ButtonSkin;
	
	
	
	public class EditLocationButtonSkin extends ButtonSkin
	{
		
		
		[Bindable]
		[Embed(source="/assets/icons/editLocationUp.png")]
		private var up:Class;
		
		
		[Bindable]
		[Embed(source="/assets/icons/editHighlight.png")]
		private var highlight:Class;
		
		protected var hl:Image = new Image();
		
		public function EditLocationButtonSkin()
		{
			super();
			width = 552;
			height = 158;
			
			hl.source = highlight;
			hl.width = 552;
			hl.height = 158;
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
				hl.visible = true;
				return up;
			}
			else{
				labelDisplay.setStyle("color",0x48250A);
				hl.visible = false;
				return up;
			}
			
			
			
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			setElementPosition(labelDisplay, 40, 55);
			setElementPosition(labelDisplayShadow, labelDisplay.x, labelDisplay.y + 1);
			//border.blendMode = "multiply";	
		}
		
		
		
	}
}