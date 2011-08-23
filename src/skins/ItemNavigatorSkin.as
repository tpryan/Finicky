package skins
{
	import components.ItemNavigator;
	
	import spark.components.Group;
	import spark.primitives.BitmapImage;
	import spark.skins.mobile.SkinnableContainerSkin;
	
	public class ItemNavigatorSkin extends SkinnableContainerSkin
	{
		
		[Bindable]
		[Embed(source="/assets/bg/detailBanner.png")]
		private var bgClass:Class;
		
		protected var bg:BitmapImage;
		protected var bgHolder:Group;
		
		public function ItemNavigatorSkin()
		{
			super();
			
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void{
			
			var host:ItemNavigator = hostComponent as ItemNavigator;
			
			if (!bg){
				bg = new BitmapImage();
				bg.source = bgClass;
				bg.scaleMode = "stretch";
				bg.width = host.width - 50;
				host.addElement(bg);
				host.itemLabel.depth = 2;
				host.leftBtn.depth = 0;
				host.rightBtn.depth = 0;
				host.leftBtn.label = "";
				host.rightBtn.label = "";
				bg.depth = 1;
			}
			
			super.layoutContents(unscaledWidth, unscaledHeight);
			setElementSize(bg,hostComponent.width - 50, 211);
			setElementPosition(bg,hostComponent.width/2 - bg.width/2, 0);
			setActualSize(hostComponent.width, 211);
			
		}
	}
}