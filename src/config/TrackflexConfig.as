package config
{
	public class TrackflexConfig
	{
		public static const NO_LOOP		:	int	= 0;
		public static const LOOP_ONE	:	int	= 1;
		public static const LOOP_ALL	:	int	= 2;
		
		private static var _random		: Boolean	= false;
		private static var _loop		: int		= NO_LOOP;
		private static var _libraryDir 	: String	= "";
		
		public static function get libraryDir()	: String
		{
			return _libraryDir;
		}

		public static function set libraryDir(value : String) : void
		{
			_libraryDir = value;
		}

		public static function get loop() : int
		{
			return _loop;
		}

		public static function set loop(value : int) : void
		{
			_loop = value;
		}

		public static function get random() : Boolean
		{
			return _random;
		}

		public static function set random(value : Boolean) : void
		{
			_random = value;
		}

		public static function load() : void
		{
			
		}
		
		public static function save() : void
		{
			
		}
	}
}