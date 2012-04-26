package model
{
	public class Artist
	{
		private var _name 		: String;
		private var _albumList	: Vector.<Album>;
		
		public function Artist()
		{
			_albumList = new Vector.<Album>();
		}
		
		public function get albumList() : Vector.<Album>	{ return _albumList; }
		public function get name() 		: String 			{ return _name; }
		
		public function set albumList(value : Vector.<Album>) 	: void	{ _albumList = value; }
		public function set name(value : String) 				: void 	{ _name = value; }

	}
}