package skins
{
	import flash.display.DisplayObject;
	
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.primitives.BitmapImage;
	import spark.skins.mobile.ButtonSkin;
	
	
	
	public class EditLocationButtonSkin extends ButtonSkin
	{
		
		
		[Bindable]
		[Embed(source="/assets/icons/editLocationUp.png")]
		private var up:Class;
		
		
		[Bindable]
		[Embed(source="/assets/icons/edithighlight.png")]
		private var highlight:Class;
		
		protected var hl:BitmapImage = new BitmapImage();
		protected var hlHolder:Group = new Group();
		
		protected var itemHeight:int = 158;
		protected var fontSize:int = 40;
		
		public function EditLocationButtonSkin()
		{
			super();
			
			if (applicationDPI == 160){
				itemHeight = 79;
				fontSize = 20;
			}
			
			
			width = 383;
			height = itemHeight;
			
			addChild(hlHolder);
			
			hl.source = highlight;
			hl.width = 383;
			hl.height = itemHeight;
			hl.x = 0;
			hl.y = 0;
			hl.visible = false;
			hlHolder.addElement(hl);
			
		}
		
		
		override protected function labelDisplay_valueCommitHandler(event:FlexEvent):void 
		{
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
			
			if (applicationDPI == 160){
				setElementPosition(labelDisplay, 20, 23);
			}
			else{
				setElementPosition(labelDisplay, 40, 55);
			}
			
			
			setElementPosition(labelDisplayShadow, labelDisplay.x, labelDisplay.y + 1);
			hl.width = hostComponent.width;
			hl.y = border.y -1 ;
		}
		
		
		
	}
}