package webservices
{
	import flash.events.Event;
	
	public class ServiceLastFMEvent extends Event
	{
		static public const TRACK_GET_INFO:String = 'track.getinfo';
		static public const ALBUM_GET_INFO:String = 'album.getinfo';
		static public const ARTIST_GET_INFO:String = 'artist.getInfo';
		
		public var result:XML;
		public var resultData:XML;
		
		public function ServiceLastFMEvent(p_type:String, p_result:XML,
										   p_bubbles:Boolean=false, p_cancelable:Boolean=false){
			super(p_type, p_bubbles, p_cancelable);
			result = new XML(p_result);
		}
	}
}