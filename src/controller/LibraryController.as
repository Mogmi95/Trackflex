package controller
{
	import model.Library;

	public static class LibraryController
	{
		public static function loadFromDir(pathname : String) : Library
		{
			var library 	: Library	= new Library();
			
			return library;
		}
	}
}