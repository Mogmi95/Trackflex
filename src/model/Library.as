package model
{
	import flash.utils.Dictionary;

	public class Library
	{
		private var _dirDictionary	: Dictionary;
		
		public function Library()
		{
			_dirDictionary = new Dictionary();
		}

		public function get dirDictionary() 	: Dictionary	{ return _dirDictionary; }

		public function set dirDictionary(value : Dictionary) 	: void	{ _dirDictionary = value; }

	}
}