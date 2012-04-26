package controller
{
	import model.Artist;

	public static class ArtistController
	{
		public static function loadFromDir(pathname : String) : Artist
		{
			var artist 	: Artist	= new Artist();
			
			return artist;
		}
	}
}