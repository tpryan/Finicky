package skins
{
	import components.Location;
	
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	import spark.components.Image;
	import spark.components.supportClasses.StyleableTextField;
	import spark.skins.mobile.SkinnableContainerSkin;
	
	
	
	public class LocationSkin extends SkinnableContainerSkin
	{
		
		[Bindable]
		[Embed(source="/assets/bg/bg_location.png")]
		private var bgClass:Class;
		
		[Bindable]
		[Embed(source="/assets/bg/bg_location_filter.png")]
		private var bgFilterClass:Class;
		
		protected var bg:Image;
		protected var bgFilter:Image;
		
		
		protected var locationLabel:StyleableTextField = new StyleableTextField();
		protected var dropshadow:flash.filters.DropShadowFilter = new flash.filters.DropShadowFilter();
		
		public function LocationSkin()
		{
			super();
			
			dropshadow.alpha = .9;
			dropshadow.color = 0x000000;
			dropshadow.angle = 120;
			dropshadow.distance = 1;
			
		}
		
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
		
		
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void{
			var host:Location = hostComponent as Location;
			locationLabel = host.locationLabel;
			super.layoutContents(unscaledWidth, unscaledHeight);
			
			if (!bg){
				bg = new Image();
				bg.source = bgClass;
				
				bg.percentWidth = 100;
				bg.height = 333;
				bg.scaleMode = "stretch";
				host.addElement(bg);
				
				bgFilter = new Image();
				bgFilter.source = bgFilterClass;
				bgFilter.width = 191;
				bgFilter.height = 226;
				bgFilter.x = host.width - bgFilter.width;
				bgFilter.y = 89;
				addChild(bgFilter);
				
			}
			
			
			locationLabel.autoSize = "left";
			locationLabel.setStyle("fontFamily", "Spoleto");
			
			locationLabel.setStyle("fontSize", 60);
			locationLabel.setStyle("color", 0xFFFFFF);
			locationLabel.rotation = -15.5;
			locationLabel.filters = [dropshadow];
			
			
		}
		
		
	}
}