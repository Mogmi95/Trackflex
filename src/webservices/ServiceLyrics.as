package webservices
{
	import mx.rpc.AsyncToken;
	import mx.rpc.http.HTTPService;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class ServiceLyrics extends HTTPService
	{
		static private var _baseURL:String ='http://api.chartlyrics.com/apiv1.asmx/SearchLyricDirect';
		public function ServiceLyrics()
		{
			super();
			
			method = 'GET';
			url = _baseURL;
			
			resultFormat = RESULT_FORMAT_E4X;
			addEventListener(ResultEvent.RESULT, onResult);
			addEventListener(FaultEvent.FAULT, onFault);
		}
		
		static private var _instance:ServiceLyrics;
		static public function getInstance():ServiceLyrics {
			if(!_instance)
				_instance = new ServiceLyrics();
			return _instance;
		}
		
		private function call(method:String, request:Object=null) : void {
			if(request == null)
				request = new Object();
			
			request.method = method;
			
			var token:AsyncToken = send(request);
			token.method = method;
		}
		
		public function getLyrics(artistName:String, trackName:String):Boolean {
			if (artistName == null || trackName == null)
				return false;
			var parameters:Object = new Object();
			parameters.artist = artistName;
			parameters.track = trackName;
			call(ServiceLyricsEvent.TRACK_GET_LYRICS, parameters);
			return true;
		}
		
		// Handle the request result or fault events.
		
		private function onResult(result:ResultEvent):void {
			var xml:XML = result.result as XML;
			var method:String = result.token.method;
			
			// Dispatch a specific event, add the method and the result.
			dispatchEvent(new ServiceLyricsEvent(method, xml));
		}
		
		private function onFault(event:FaultEvent):void {
			dispatchEvent(event);
		}
	}
}