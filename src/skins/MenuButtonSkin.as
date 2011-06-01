package skins
{
	import flash.desktop.Icon;
	import flash.display.DisplayObject;
	
	import mx.events.FlexEvent;
	
	import spark.components.Image;
	import spark.primitives.BitmapImage;
	import spark.skins.mobile.ButtonSkin;
	
	
	
	public class MenuButtonSkin extends ButtonSkin
	{
		
		[Bindable]
		[Embed(source="/assets/bg/bg_menuButton.png")]
		private var bgClass:Class;
		
		[Bindable]
		[Embed(source="/assets/bg/bg_menuButtonSelected.png")]
		private var bgClassSelected:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/addbtn.png")]
		private var addicon:Class;
		
		private var _border:DisplayObject;
		
		private var changeFXGSkin:Boolean = false;
		
		private var borderClass:Class;
		
		
		public function MenuButtonSkin()
		{
			super();
			this.width = 180;			
			
			
				
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			
		}
		
		/**
		 *  @private 
		 */
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
		
		/*override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			
			
			
			setIcon(addicon);
			var iconDisplay:DisplayObject = getIconDisplay();
			
		
			
			if (iconDisplay != null){
				setElementPosition(iconDisplay, 25, 15);
			}
		}	*/
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			
			
			setIcon(addicon);
			var iconDisplay:DisplayObject = getIconDisplay();
			
			
			
			if (iconDisplay != null){
				setElementPosition(iconDisplay, 25, 15);
			}
			
		}
		
		private function layoutBorder(unscaledWidth:Number, unscaledHeight:Number):void
		{
			setElementSize(border, unscaledWidth, unscaledHeight);
			setElementPosition(border, 0, 0);
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
		
		
		
		
	}
	
	
}