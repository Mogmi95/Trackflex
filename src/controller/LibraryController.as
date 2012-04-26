package controller
{	
	import flash.filesystem.File;
	
	import model.Artist;
	import model.Library;

	public class LibraryController
	{
		public static function loadFromDir(dir : File) : Library
		{
			var library 	: Library	= new Library();
			var subdirs		: Array		= dir.getDirectoryListing();
			
			for each (var subdir : File in subdirs)
			{
				var tmpArtist 	: Artist	= new Artist();
				
				tmpArtist.name = subdir.name;
				library.artistList.push(tmpArtist);
				trace(subdir.name);
			}
			library.artistList.sort(Array.CASEINSENSITIVE);
			
			return library;
		}
	}
}