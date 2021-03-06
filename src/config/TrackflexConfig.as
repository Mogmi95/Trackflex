package config
{
	import controller.LibraryController;
	import controller.PlayerController;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class TrackflexConfig
	{
		public static const NO_LOOP		:	int	= 0;
		public static const LOOP_ONE	:	int	= 1;
		public static const LOOP_ALL	:	int	= 2;
		
		private static var _random		: Boolean	= false;
		private static var _loop		: int		= NO_LOOP;
		private static var _libraryDir 	: String	= "";
		
		public static function get libraryDir()	: String
		{
			return _libraryDir;
		}

		public static function set libraryDir(value : String) : void
		{
			_libraryDir = value;
		}

		public static function get loop() : int
		{
			return _loop;
		}

		public static function set loop(value : int) : void
		{
			_loop = value;
		}

		public static function get random() : Boolean
		{
			return _random;
		}

		public static function set random(value : Boolean) : void
		{
			_random = value;
		}

		public static function load() : void
		{
			var loader	: URLLoader 	= new URLLoader();
			var request	: URLRequest 	= new URLRequest(File.applicationDirectory.resolvePath("config.xml").nativePath);

			loader.addEventListener(Event.COMPLETE, onCompleteHandler);
			loader.load(request);
		}
		
		public static function save() : void
		{
			var fileStream 	: FileStream	= new FileStream();
			var file 		: File			= new File(File.applicationDirectory.resolvePath("config.xml").nativePath);
			var sendXML		: String		= "";
			
			sendXML += "<root>" +
							"<librarydir value=\"" + _libraryDir + "\" />" +
							"<loop value=\"" + _loop + "\" />" +
							"<random value=\"" + _random + "\" />" +
							"<volume value=\"" + PlayerController.volume + "\" />" +
						"</root>";
			
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeMultiByte(String(sendXML), "UTF-8");
		}
		
		private static function onCompleteHandler(event : Event) : void
		{
			var xml		 	: XML 		= new XML(event.target.data);
			var elements	: XMLList 	= xml.elements();
			
			if (xml..librarydir[0] != null)
				_libraryDir = xml..librarydir[0].@value;
			if (xml..loop[0] != null)
				_loop = xml..loop[0].@value;
			if (xml..random[0] != null)
				_random = xml..random[0].@value;
			if (xml..volume[0] != null)
				PlayerController.volume = xml..volume[0].@value;
			
			LibraryController.setLibraryDir(new File(_libraryDir));
			LibraryController.populateView();
			PlayerController.updateIcons();
		}
	}
}