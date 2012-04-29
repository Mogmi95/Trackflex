package webservices
{
	import flash.events.Event;
	
	public class ServiceLyricsEvent extends Event
	{
		static public const TRACK_GET_LYRICS:String = '';
		public var result:XML;	
		
		
		public function ServiceLyricsEvent(p_type:String, p_result:XML,
										   p_bubbles:Boolean=false, p_cancelable:Boolean=false)
		{
			super(p_type, p_bubbles, p_cancelable);
			result = new XML(p_result);
		}
	}
}