package skins
{
	import spark.skins.mobile.ButtonSkin;
	
	public class AlertOKButtonSkin extends ButtonSkin
	{
		
		
		
		[Bindable]
		[Embed(source="/assets/icons/okButtonUp.png")]
		private var up:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/okButtonDown.png")]
		private var down:Class;
		
		
		public function AlertOKButtonSkin()
		{
			super();
			width=118;
			height=127;
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