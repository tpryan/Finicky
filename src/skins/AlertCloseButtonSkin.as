package skins
{
	import spark.skins.mobile.ButtonSkin;
	
	public class AlertCloseButtonSkin extends ButtonSkin
	{
		[Bindable]
		[Embed(source="/assets/icons/closeButtonUp.png")]
		private var up:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/closeButtonDown.png")]
		private var down:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/closeButtonUp160.png")]
		private var up160:Class;
		
		[Bindable]
		[Embed(source="/assets/icons/closeButtonDown160.png")]
		private var down160:Class;
		
		
		public function AlertCloseButtonSkin()
		{
			super();
			
			
			if (applicationDPI == 160){
				width=59;
				height=63;
			}
			else{
				width=118;
				height=127;
			}
		}
		
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			
		}
		
		override protected function getBorderClassForCurrentState():Class
		{
			if (currentState == "down"){
				return getDownClass();
			}
			else{
				return getUpClass();
			}
			
		}
		
		protected function getUpClass():Class{
			if (applicationDPI == 160){
				return up160;
			}
			else{
				return up;
			}
		}
		
		protected function getDownClass():Class{
			if (applicationDPI == 160){
				return down160;
			}
			else{
				return down;
			}
		}
		
	}
}