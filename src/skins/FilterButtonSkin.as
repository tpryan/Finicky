package skins
{
	import mx.events.FlexEvent;
	
	import spark.skins.mobile.ButtonSkin;
	
	public class FilterButtonSkin extends ButtonSkin
	{
		
		[Bindable]
		[Embed(source="/assets/icons/filterbuttonDown.png")]
		private var down:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/filterbuttonUp.png")]
		private var up:Class;
		
		public function FilterButtonSkin()
		{
			super();
			width = 243;
			height = 103;
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
				return down;
			}
			else{
				return up;
			}	
		}
		
	}
}