package skins
{
	import flash.display.DisplayObject;
	
	import mx.events.FlexEvent;
	
	import spark.skins.mobile.ViewMenuItemSkin;
	
	public class DetailsViewMenuItemSkin extends ViewMenuItemSkin
	{
		
		[Bindable]
		[Embed(source="/assets/bg/bg_blank.png")]
		private var bgClass:Class;
		
		[Bindable]
		[Embed(source="/assets/bg/bg_menuButtonSelected.png")]
		private var bgClassSelected:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/addbtn.png")]
		private var addicon:Class;
		
		
		public function DetailsViewMenuItemSkin()
		{
			super();
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
		
		override protected function getBorderClassForCurrentState():Class
		{
			if (currentState == "down"){
				return bgClassSelected;
			}
			else{
				return bgClass;
			}	
		}
		
		override protected function labelDisplay_valueCommitHandler(event:FlexEvent):void 
		{
			super.labelDisplay_valueCommitHandler(event);
			labelDisplayShadow.text = labelDisplay.text;
			
			
			
			labelDisplay.setStyle("fontFamily","Liberator");
			labelDisplay.setStyle("fontSize",40);
			labelDisplay.setStyle("fontWeight","normal");
			labelDisplay.setStyle("color",0x71491D);
			labelDisplayShadow.setStyle("fontFamily","Liberator");
			labelDisplayShadow.setStyle("fontSize",40);
			labelDisplayShadow.setStyle("fontWeight","normal");
			
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
			super.layoutContents(unscaledWidth, unscaledHeight);
			labelDisplay.y = labelDisplay.y + 15; 
			labelDisplayShadow.y = labelDisplayShadow.y + 15;
			border.y = border.y + 15;
			
			/*setIcon(addicon);
			var iconDisplay:DisplayObject = getIconDisplay();*/
			
			
			
			/*if (iconDisplay != null){
				setElementPosition(iconDisplay, 25, 15);
			}*/
			
		}
		
	}
}