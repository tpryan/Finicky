package skins
{
	import mx.events.FlexEvent;
	
	import spark.components.Image;
	import spark.skins.mobile.ButtonSkin;
	
	public class OkButtonSkin extends ButtonSkin
	{
		
		
		[Bindable]
		[Embed(source="/assets/icons/okUp.png")]
		private var up:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/okDown.png")]
		private var down:Class;
		
		
		public function OkButtonSkin()
		{
			super();
			width = 401;
			height = 161;
			
		}
		
		
		override protected function labelDisplay_valueCommitHandler(event:FlexEvent):void 
		{
			super.labelDisplay_valueCommitHandler(event);
			labelDisplayShadow.text = labelDisplay.text;
			
			
			
		}

		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			
		}
		
		override protected function getBorderClassForCurrentState():Class
		{
			if (currentState == "down"){
				return down;
			}
			else{
				return up;
			}
			
			
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			//border.blendMode = "multiply";	
		}
		
	}
}