package model
{
	public class Track
	{
		private var _title 	: String;
		private var _length	: int;
		private var _album 	: Album;
		private var _artist	: Artist;
		
		public function Track()
		{
		}

		public function get title() : String 	{ return _title; }
		public function get length() : int 		{ return _length; }
		public function get album() : Album 	{ return _album; }
		public function get artist() : Artist 	{ return _artist; }

		public function set title(value : String) 	: void 	{ _title = value; }
		public function set length(value : int) 	: void 	{ _length = value; }
		public function set album(value : Album) 	: void 	{ _album = value; }
		public function set artist(value : Artist) 	: void 	{ _artist = value; }

	}
}