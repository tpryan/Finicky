package skins
{
	import spark.skins.mobile.RadioButtonSkin;
	import mx.core.DPIClassification;
	

	
	public class CheckRadioButtonSkin extends RadioButtonSkin
	{
		[HostComponent("spark.components.RadioButton")]
		
		[Bindable]
		[Embed(source="/assets/icons/modalCheckOff.png")]
		private var off:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/modalCheckOn.png")]
		private var on:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/modalCheckOff160.png")]
		private var off160:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/modalCheckOn160.png")]
		private var on160:Class;
		
		
		public function CheckRadioButtonSkin()
		{
			super();
			
			switch (applicationDPI)
			{
				case DPIClassification.DPI_160:
				{
					upIconClass = off160;
					upSelectedIconClass = on160;
					downIconClass = on160;
					downSelectedIconClass = on160;
					upSymbolIconClass =  off160;
					downSymbolIconClass =  on160;
					upSymbolIconSelectedClass = on160;
					downSymbolIconSelectedClass = on160;
					
					
					break;
				}
				default:
				{
					upIconClass = off;
					upSelectedIconClass = on;
					downIconClass = on;
					downSelectedIconClass = on;
					upSymbolIconClass =  off;
					downSymbolIconClass =  on;
					upSymbolIconSelectedClass = on;
					downSymbolIconSelectedClass = on;
					
					
					break;
				}
			}
			
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			hostComponent.setStyle("iconPlacement", "bottom");
			labelDisplay.setStyle("fontFamily", "Liberator");
			labelDisplay.setStyle("color", 0x383539);
			if (applicationDPI == 160){
				labelDisplay.setStyle("fontSize", 27);
			}
			else{
				labelDisplay.setStyle("fontSize", 54);
			}
			
			
		}
		
	}
}