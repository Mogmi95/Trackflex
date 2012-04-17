package webservices
{
	public class ServiceLastFM extends HTTPService
	{
		static private var _apiKey:String = '7b36c2365fed1c01db36276aa86d89ba';
		static private var _baseURL:String = 'http://ws.audioscrobbler.com/2.0/';
		
		public function ServiceLastFM()
		{
			super();
		}
	}
}