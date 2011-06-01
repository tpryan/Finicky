package renderers
{
	import spark.components.IconItemRenderer;
	
	public class NoBackGround extends IconItemRenderer
	{
		public function NoBackGround()
		{
			super();
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			
		}
	}
}