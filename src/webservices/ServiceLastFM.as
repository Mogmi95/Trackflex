package webservices
{
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class ServiceLastFM extends HTTPService
	{
		static private var _apiKey:String = '7b36c2365fed1c01db36276aa86d89ba';
		static private var _baseURL:String = 'http://ws.audioscrobbler.com/2.0/';
		
		public function ServiceLastFM()
		{
			super();
			// Init.
			method = 'GET';
			url = _baseURL;
			
			resultFormat = RESULT_FORMAT_E4X;
			addEventListener(ResultEvent.RESULT, onResult);
			addEventListener(FaultEvent.FAULT, onFault);
		}
		
		static private var _instance:ServiceLastFM;
		static public function getInstance():ServiceLastFM {
			if(!_instance)
				_instance = new ServiceLastFM();
			return _instance;
		}
		private function call(method:String, request:Object=null) : void {
			if(request == null)
				request = new Object();
			
			request.method = method;
			request.api_key = _apiKey;
			
			var token:AsyncToken = send(request);
			token.method = method;
		}
		
		public function getArtistInfo(artistName:String):Boolean{
			if (artistName == null){
				return false;
			}
			var parameters:Object = new Object();
			parameters.artist = artistName;
			call(ServiceLastFMEvent.ARTIST_GET_INFO, parameters);
			return true;
		}
		
		
		public function getTrackInfo(artistName:String, trackName:String):Boolean {
			if (artistName == null || trackName == null)
				return false;
			var parameters:Object = new Object();
			parameters.artist = artistName;
			parameters.track = trackName;
			call(ServiceLastFMEvent.TRACK_GET_INFO, parameters);
			return true;
		}
		
		public function getAlbumInfo(artistName:String, albumName:String):Boolean {
			if (artistName == null || albumName == null)
				return false;
			var parameters:Object = new Object();
			parameters.artist = artistName;
			parameters.album = albumName;
			call(ServiceLastFMEvent.ALBUM_GET_INFO, parameters);
			return true;
		}
		// Handle the request result or fault events.
		
		private function onResult(result:ResultEvent):void {
			var xml:XML = result.result as XML;
			var method:String = result.token.method;
			
			// Dispatch a specific event, add the method and the result.
			dispatchEvent(new ServiceLastFMEvent(method, xml));
		}
		
		private function onFault(event:FaultEvent):void {
			dispatchEvent(event);
		}
	}
}