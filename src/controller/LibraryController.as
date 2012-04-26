package controller
{
	import model.Library;

	public static class LibraryController
	{
		private static var _library 	: Library 	= null;
		
		public static function loadFromDir(pathname : String) : Library
		{
			_library = new Library();
			
			return _library;
		}
	}
}