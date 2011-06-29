package skins
{
	import spark.skins.mobile.ButtonSkin;
	
	public class ChangeLocationButtonSkin extends ButtonSkin
	{
		
		
		
		[Bindable]
		[Embed(source="/assets/icons/changelocationup.png")]
		private var up:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/changelocationdown.png")]
		private var down:Class;
		
		
		public function ChangeLocationButtonSkin()
		{
			super();
			width=93;
			height=27;
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