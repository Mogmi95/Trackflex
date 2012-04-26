package model
{
	public class Album
	{
		private var _trackList	: Vector.<Track>;
		private var _artist		: Artist;
		private var _title		: String;
		
		public function Album()
		{
			_trackList = new Vector.<Track>();
		}

		public function get trackList() : Vector.<Track>	{ return _trackList; }
		public function get artist() 	: Artist 			{ return _artist; }
		public function get title() 	: String 			{ return _title; }

		public function set trackList(value : Vector.<Track>) 	: void	{ _trackList = value; }
		public function set artist(value : Artist) 				: void 	{ _artist = value; }
		public function set title(value : String) 				: void 	{ _title = value; }

	}
}