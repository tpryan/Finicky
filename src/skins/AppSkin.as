package skins
{
	import flash.system.Capabilities;
	
	import spark.components.Image;
	import spark.components.ViewNavigator;
	import spark.skins.mobile.ViewNavigatorApplicationSkin;
	import spark.skins.mobile.supportClasses.MobileSkin;
	
	public class AppSkin extends ViewNavigatorApplicationSkin
	{
		
		[Bindable]
		[Embed(source="/assets/bg/bg_list.jpg")]
		private var bgClass:Class;
		
		private var bg:Image = new Image();
		
		public function AppSkin()
		{
			super();
			bg.source = bgClass;
			bg.horizontalCenter = 0;
			bg.width = 680;
			bg.height = 960;
			addChild(bg);
			
		}
		
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			bg.x = -340 + unscaledWidth/2;
			bg.y = -480 + unscaledHeight/2;
			
		}
		
	}
}