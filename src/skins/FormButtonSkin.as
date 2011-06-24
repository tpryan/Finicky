package skins
{
	import mx.events.FlexEvent;
	
	import spark.components.Image;
	import spark.skins.mobile.ButtonSkin;
	
	public class FormButtonSkin extends ButtonSkin
	{
		
		
		[Bindable]
		[Embed(source="/assets/icons/formbuttonUp.png")]
		private var up:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/formhighlight.png")]
		private var highlight:Class;
		
		protected var hl:Image = new Image();
		
		public function FormButtonSkin()
		{
			super();
			width = 194;
			height = 82;
			
			hl.source = highlight;
			hl.width = 194;
			hl.height = 82;
			hl.x = 0;
			hl.y = 0;
			hl.visible = false;
			addChild(hl);
		}
		
		
		override protected function labelDisplay_valueCommitHandler(event:FlexEvent):void 
		{
			super.labelDisplay_valueCommitHandler(event);
			labelDisplayShadow.text = labelDisplay.text;
			
			labelDisplay.setStyle("fontFamily","Liberator");
			labelDisplay.setStyle("fontSize",30);
			labelDisplay.setStyle("fontWeight","normal");
			labelDisplay.setStyle("color",0x48250A);
			labelDisplayShadow.setStyle("fontFamily","Liberator");
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