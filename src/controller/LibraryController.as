package controller
{	
	import flash.filesystem.File;
	import flash.utils.Dictionary;		
	
	import mx.controls.Label;
	import mx.core.FlexGlobals;
	
	import view.LibraryView;
	import view.itemrenderer.LibraryItemRenderer;
	import view.itemrenderer.LibrarySeparatorRenderer;

	public class LibraryController
	{
		private static var _view 	: LibraryView		= FlexGlobals.topLevelApplication.library;
		
		private static var _dirList	: Vector.<String>	= new Vector.<String>();
		private static var _libPath	: String;
		
		public static function get dirList() 	: Vector.<String>	{ return _dirList; }
		public static function get libPath() 	: String			{ return _libPath; }
		
		public static function loadFromDir(dir : File) : void
		{
			var subdirs		: Array		= dir.getDirectoryListing();
			
			_libPath = dir.nativePath;
			_dirList.length = 0;
			
			for each (var subdir : File in subdirs)
			{
				_dirList.push(subdir.name);
			}
			_dirList.sort(Array.CASEINSENSITIVE);
		}
		
		public static function populateView() : void
		{
			var cap	: String	= "";
			
			_view.vGroup.removeAllElements();
			
			for each (var name : String in _dirList)
			{
				if (cap.toUpperCase() != name.charAt(0).toLocaleUpperCase())
				{
					var lsr	: LibrarySeparatorRenderer	= new LibrarySeparatorRenderer();
					
					cap = name.charAt(0).toUpperCase();
					lsr.letter = cap;
					_view.vGroup.addElement(lsr);
				}
				
				var lir : LibraryItemRenderer = new LibraryItemRenderer();
				
				lir.label.text = name;
				_view.vGroup.addElement(lir);
			}

		}
	}
}