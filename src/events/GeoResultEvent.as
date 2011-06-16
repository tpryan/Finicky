package events
{
	import flash.events.Event;
	
	public class GeoResultEvent extends Event
	{
		
		public var result:Object = new Object();
		
		public function GeoResultEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}