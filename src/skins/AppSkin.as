package skins
{
	import flash.system.Capabilities;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.ViewNavigator;
	import spark.primitives.BitmapImage;
	import spark.skins.mobile.ViewNavigatorApplicationSkin;
	import spark.skins.mobile.supportClasses.MobileSkin;
	
	public class AppSkin extends ViewNavigatorApplicationSkin
	{
		
		[Bindable]
		[Embed(source="/assets/bg/bg_main.jpg")]
		private var bgClass:Class;
		
		private var bg:BitmapImage = new BitmapImage();
		private var holder:Group = new Group;
		
		
		//private var bg:Image = new Image();
		
		public function AppSkin()
		{
			
			super();
			holder.horizontalCenter = 0;
			addChild(holder);
			bg.source = bgClass;
			
			bg.width = 640;
			bg.height = 1608;
			holder.addElement(bg);
			
			
		}
		
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			bg.x = -320 + unscaledWidth/2;
			bg.y = -480 + unscaledHeight/2;
			
		}
		
	}
}