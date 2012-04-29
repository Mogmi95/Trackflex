package controller
{
	import config.TrackflexConfig;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.SampleDataEvent;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import flashx.textLayout.elements.GlobalSettings;
	import flashx.textLayout.formats.Float;
	
	import mx.core.FlexGlobals;
	
	import view.LastfmInfoView;
	import view.LyricsView;
	import view.PlayerView;

	public class PlayerController
	{
		private static var _view 			: PlayerView 		= FlexGlobals.topLevelApplication.player;
		private static var _infoview 		: LastfmInfoView 	= FlexGlobals.topLevelApplication.infos;
		private static var _lyricsview 		: LyricsView 		= FlexGlobals.topLevelApplication.lyrics;

		
		private static var _pausePoint		: Number			= 0.;
		private static var _playing			: Boolean			= false;
		private static var _currentTrack	: Sound				= null;
		private static var _soundChannel	: SoundChannel		= null;
		private static var _soundTransform	: SoundTransform	= null;
		
		public static function get currentTrack()	: Sound	{ return _currentTrack; }
		public static function get playing()		: Boolean { return _playing; }

		public static function set playing(value : Boolean)		: void { _playing = value; }
		public static function set pausePoint(value : Number)	: void 	{ _pausePoint = value; }
		public static function set currentTrack(sound : Sound) 	: void
		{
			if (_playing)
				stop();
			
			_currentTrack = sound;
			_view.time.text = "0:00/" + formatNumber(_currentTrack.length);
			_view.trackslide.value = 0.;
			var artist : String = PlayerController.currentTrack.id3.artist;
			var song : String = PlayerController.currentTrack.id3.songName;
			_infoview.getArtistInfo(artist);
			_infoview.artistName.text = artist;
			//_lyricsview.getArtistSongLyric(artist,song);
			//_lyricsview.Title.text = song;
			play();
		}
		
		public static function play() : void
		{
			if (_currentTrack == null)
				return;
			
			if (!_playing )
			{
				_soundChannel =_currentTrack.play(_pausePoint);
				_soundTransform = _soundChannel.soundTransform;
				_currentTrack.addEventListener(SampleDataEvent.SAMPLE_DATA, onProgressHandler);
				
				
				_view.play.setStyle("icon", PlayerView.ASSET_PAUSE);
				_view.addEventListener(Event.ENTER_FRAME, onProgressHandler);
				
				_soundTransform.volume = _view.volumeslide.value / 100;
				_soundChannel.soundTransform = _soundTransform;
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			}
			else
			{
				_soundChannel.stop();
				_view.play.setStyle("icon", PlayerView.ASSET_PLAY);
				_view.removeEventListener(Event.ENTER_FRAME, onProgressHandler);
			}
			
			_view.trackInfo.text = (_currentTrack.id3.artist == null ? "undefined" : _currentTrack.id3.artist)
				+ " - " + (_currentTrack.id3.songName == null ? "undefined" : _currentTrack.id3.songName);
			_playing = !_playing;
		}
		
		public static function stop() : void
		{
			if (_soundChannel != null)
			{
				_soundChannel.stop();
				_pausePoint = 0.;
				_playing = false;
				refreshTime();
				_view.trackslide.value = 0.;
				_view.play.setStyle("icon", PlayerView.ASSET_PLAY);
				_view.removeEventListener(Event.ENTER_FRAME, onProgressHandler);
				_view.trackInfo.text = "";
			}
		}
		
		public static function setVolume(vol : Number) : void
		{
			if (_soundTransform != null && _soundChannel != null)
			{
				_soundTransform.volume = vol;
				_soundChannel.soundTransform = _soundTransform;
			}
		}
		
		public static function refreshTime() : void
		{
			_view.time.text = formatNumber(_pausePoint) + "/" + formatNumber(_currentTrack.length);		
		}
		
		public static function changeSoundPosition() : void
		{
			if (_playing)
			{
				_soundChannel.stop();
				_soundChannel =_currentTrack.play(_pausePoint);
				_soundTransform.volume = _view.volumeslide.value / 100;
				_soundChannel.soundTransform = _soundTransform;
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			}
		}
		
		private static function formatNumber(n : Number) : String
		{
			var sec	: Number;
			var min	: Number;
			
			sec = int(n / 1000);
			min = int(sec / 60);
			sec = sec % 60;
			
			return min + ":" + (sec >= 10 ? sec : "0" + sec);
		}
		
		public static function onProgressHandler(event : Event) : void
		{
			if (_soundChannel != null)
				_pausePoint = _soundChannel.position;
			
			_view.time.text = formatNumber(_pausePoint) + "/" + formatNumber(_currentTrack.length);
			_view.trackslide.value = _pausePoint * 100 / _currentTrack.length / 100;
		}
		
		public static function next() : void
		{
			PlaylistController.nextTrack();
		}
		
		public static function previous() : void
		{
			PlaylistController.prevTrack();
		}
		
		private static function soundCompleteHandler(event : Event) : void
		{
			next();
		}
	}
}