package controller
{	
	import config.TrackflexConfig;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.core.FlexGlobals;
	
	import spark.components.Image;
	import spark.components.Label;
	
	import view.LibraryView;
	import view.itemrenderer.LibraryItemRenderer;
	import view.itemrenderer.LibrarySeparatorRenderer;

	public class LibraryController
	{
		private static var _view 		: LibraryView		= FlexGlobals.topLevelApplication.library;
		
		private static var _dirList		: Vector.<String>	= new Vector.<String>();
		private static var _trackOrder	: Vector.<String> 	= new Vector.<String>();
		private static var _trackList	: Dictionary		= new Dictionary();
		private static var _libPath		: String 			= "";
		private static var _subdirPath	: String 			= "";
		private static var _coverPath	: String 			= "";
		private static var _increment	: int				= 0;
		
		private static var _trackStack	: Vector.<String>	= new Vector.<String>();
		
		public static function get trackList() 	: Dictionary			{ return _trackList; }
		public static function get dirList() 	: Vector.<String>	{ return _dirList; }
		public static function get path() 		: String			{ return _libPath + _subdirPath; }

		public static function setLibraryDir(dir : File) : void
		{
			_libPath = dir.nativePath;
			
			loadFromDir("");
		}
		
		public static function loadFromDir(subpath : String) : void
		{
			var dir			: File		= new File(_libPath + _subdirPath + "/" + subpath);
			var subdirs		: Array		= dir.getDirectoryListing();
			
			if (subpath != "")
				_subdirPath += "/" + subpath;
			_dirList.length = 0;
			_trackStack.length = 0;
			_trackOrder.length = 0;
			_trackList = new Dictionary();
			
			_coverPath = "";
			
			for each (var f : File in subdirs)
			{
				if (f.isDirectory)
					_dirList.push(f.name);
				else if (isMusic(f.name))
					_trackStack.push(f.name);
				else if (_coverPath == "" && isImage(f.name))
					_coverPath = f.name;
			}
			_dirList.sort(Array.CASEINSENSITIVE);
			TrackflexConfig.libraryDir = _libPath;
		}
		
		public static function populateView() : void
		{
			var cap	: String	= "";
			
			_view.libraryGroup.removeAllElements();
			_view.trackGroup.removeAllElements();
			
			var label	: Label	= new Label();
			
			label.text = "  << Previous";
			label.buttonMode = true;
			label.enabled = (_subdirPath.length != 0);
			label.addEventListener(MouseEvent.CLICK, previousClickHandler);
			label.addEventListener(MouseEvent.ROLL_OVER, LibraryItemRenderer.label_rollOverHandler);
			label.addEventListener(MouseEvent.ROLL_OUT, LibraryItemRenderer.label_rollOutHandler);
			label.height = 30;
			label.setStyle("verticalAlign", "bottom");
			_view.libraryGroup.addElement(label);
			
			if (_dirList.length == 0 && _coverPath != "" && _trackStack.length != 0)
			{
				var img	: Image	= new Image();

				img.source = _libPath + _subdirPath + "/" +_coverPath;
				img.horizontalCenter = 0;
				img.width = 248;
				img.height = 248;
				_view.libraryGroup.gap = 20;
				_view.libraryGroup.addElement(img);
			}
			else
			{
				_view.libraryGroup.gap = 0;
			}

			for each (var name : String in _dirList)
			{
				if (cap.toUpperCase() != name.charAt(0).toLocaleUpperCase())
				{
					var lsr	: LibrarySeparatorRenderer	= new LibrarySeparatorRenderer();
					
					cap = name.charAt(0).toUpperCase();
					lsr.letter = cap;
					_view.libraryGroup.addElement(lsr);
				}
				
				var lir : LibraryItemRenderer = new LibraryItemRenderer();
				
				lir.currentState = "dir";
				lir.name = name;
				_view.libraryGroup.addElement(lir);
			}
			
			if (_trackStack.length != 0)
			{
				var label_	: Label	= new Label();
				
				label_.text = "  >> Add all";
				label_.buttonMode = true;
				label_.addEventListener(MouseEvent.CLICK, addAllClickHandler);
				label_.addEventListener(MouseEvent.ROLL_OVER, LibraryItemRenderer.label_rollOverHandler);
				label_.addEventListener(MouseEvent.ROLL_OUT, LibraryItemRenderer.label_rollOutHandler);
				label_.height = 30;
				_view.trackGroup.addElement(label_);
				
				loadTrack();
			}
		}
		
		private static function loadTrack() : void
		{
			if (_trackStack.length == 0)
				return;
			
			var track	: String	= _trackStack.shift();
			var sound 	: Sound		= new Sound();
			
			sound.addEventListener(Event.COMPLETE, onCompleteHandler);
			sound.load(new URLRequest(LibraryController.path + "/" + track));
		}
		
		private static function onCompleteHandler(event : Event) : void
		{
			var lir 	: LibraryItemRenderer 	= new LibraryItemRenderer();
			var sound 	: Sound					= Sound(event.target);
			var name	: String;
			
			name = sound.id3.songName == null ? "undefined_" + _increment++ : sound.id3.songName;
			_trackList[name] = sound;
			_trackOrder.push(name);
			
			lir.currentState = "track";
			lir.name = name;
			_view.trackGroup.addElement(lir);
			
			loadTrack();
		}
		
		private static function isMusic(name : String) : Boolean
		{
			var arr : Array		= name.split(".");
			var ext	: String	= arr[arr.length - 1];
			
			return (ext.toLowerCase() == "mp3");
		}
		
		private static function isImage(name : String) : Boolean
		{
			var arr : Array		= name.split(".");
			var ext	: String	= arr[arr.length - 1];
			
			return (ext.toLowerCase() == "jpg" || ext.toLowerCase() == "png");
		}
		
		private static function addAllClickHandler(event : MouseEvent) : void
		{
			for each (var track : String in _trackOrder)
			{
				PlaylistController.addTrack(_trackList[track]);
			}
		}
		
		private static function previousClickHandler(event : MouseEvent) : void
		{
			var arr		: Array		= _subdirPath.split("/");
			var prevDir	: String	= "";
			
			for (var i : int = 1; i < arr.length - 1; ++i)
			{
				prevDir += "/" + arr[i];
			}
			
			_subdirPath = prevDir;
			loadFromDir("");
			populateView();
		}
	}
}