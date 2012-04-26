package model
{
	public class Library
	{
		private var _artistList	: Vector.<Artist>;
		
		public function Library()
		{
			_artistList = new Vector.<Artist>();
		}

		public function get artistList() 	: Vector.<Artist>	{ return _artistList; }

		public function set artistList(value : Vector.<Artist>) 	: void	{ _artistList = value; }

	}
}