package skins
{
	import flash.display.Sprite;
	
	import mx.charts.HitData;
	
	import spark.components.Button;
	import spark.skins.mobile.ButtonSkin;
	
	public class BannerButtonSkin extends ButtonSkin
	{
		
		[Embed(source='/assets/icons/detailBannerLeft.png')]
		private static var detailLeft:Class;
		
		[Embed(source='/assets/icons/detailBannerRight.png')]
		private static var detailRight:Class;
		
		[Embed(source='/assets/icons/detailBannerLeftActive.png')]
		private static var detailLeftActive:Class;
		
		[Embed(source='/assets/icons/detailBannerRightActive.png')]
		private static var detailRightActive:Class;
		
		private var up:Class;
		private var down:Class;
		
		public function BannerButtonSkin()
		{
			super();
			
			width = 110;
			height= 181;
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
		
		}
		
		override protected function getBorderClassForCurrentState():Class
		{
			
			if (hostComponent.id.indexOf("right")>= 0){
				up = detailRight;
				down = detailRightActive;
			}
			else{
				up = detailLeft;
				down = detailLeftActive;
			}
			
			if (currentState == "down"){
				return down;
			}
			else{
				return up;
			}
			
		}
		
		
		
	}
}