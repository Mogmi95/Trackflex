package controller
{
	import config.TrackflexConfig;
	
	import flash.events.Event;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.core.FlexGlobals;
	
	import view.PlaylistView;
	import view.itemrenderer.TrackButtonRenderer;

	public class PlaylistController
	{
		private static var _view		: PlaylistView		= FlexGlobals.topLevelApplication.playlist;
		
		private static var _playlist	: Vector.<Sound>	= new Vector.<Sound>();
		private static var _currentPos	: int				= 0;
		
		public static function addTrack(sound : Sound) : void
		{
			var track	: Object = { button : new TrackButtonRenderer(),
									 title : sound.id3.songName == null ? "undefined" : sound.id3.songName,
									 artist : sound.id3.artist == null ? "undefined" : sound.id3.artist,
									 album : sound.id3.album == null ? "undefined" : sound.id3.album};
			
			IList(_view.grid.dataProvider).addItem(track);
			_playlist.push(sound);
		}
		
		public static function play(pos : int) : void
		{
			_currentPos = pos;
			PlayerController.currentTrack = _playlist[_currentPos];
		}
		
		public static function removeTrack(index : int) : void
		{
			var l	: int	=  _playlist.length - 1;
			
			for (var i : int = index; i < l; ++i)
			{
				_playlist[i] = _playlist[i + 1];
			}
			--_playlist.length;
			
		}
		
		public static function clearAll() : void
		{
			while (_playlist.length != 0)
				removeTrack(0);
			IList(_view.grid.dataProvider).removeAll();
		}
		
		public static function swapTrack(index1 : int, index2 : int) : void
		{
			var tmp	: Sound	= _playlist[index1];
			
			_playlist[index1] = _playlist[index2];
			_playlist[index2] = tmp;
		}
		
		public static function nextTrack() : void
		{
			if (_currentPos < _playlist.length - 1)
			{
				if (TrackflexConfig.random && TrackflexConfig.loop != TrackflexConfig.LOOP_ONE)
					_currentPos = randomize();
				else if (TrackflexConfig.loop == TrackflexConfig.NO_LOOP || TrackflexConfig.loop == TrackflexConfig.LOOP_ALL)
					++_currentPos
			}
			else if (TrackflexConfig.loop == TrackflexConfig.LOOP_ALL)
			{
				_currentPos = 0;	
			}
			else if (TrackflexConfig.loop == TrackflexConfig.NO_LOOP)
			{
				return;
			}
			
			if (_playlist.length != 0)
				PlayerController.currentTrack = _playlist[_currentPos];
			_view.grid.selectedIndex = _currentPos;
		}
		
		public static function prevTrack() : void
		{
			if (_currentPos > 0)
			{
				if (TrackflexConfig.random && TrackflexConfig.loop != TrackflexConfig.LOOP_ONE)
					_currentPos = randomize();
				else if (TrackflexConfig.loop == TrackflexConfig.NO_LOOP || TrackflexConfig.loop == TrackflexConfig.LOOP_ALL)
					--_currentPos;
			}
			else if (TrackflexConfig.loop == TrackflexConfig.LOOP_ALL)
			{
				_currentPos = _playlist.length - 1;
			}
			else if (TrackflexConfig.loop == TrackflexConfig.NO_LOOP)
			{
				return;
			}
			
			if (_playlist.length != 0)
				PlayerController.currentTrack = _playlist[_currentPos];
			_view.grid.selectedIndex = _currentPos;
		}
			
		private static function randomize() : int
		{
			var newpos	: int	= Math.floor(Math.random() * _playlist.length);
			
			while (newpos == _currentPos)
				newpos = Math.floor(Math.random() * _playlist.length);
			
			return newpos;
		}
	}
}