package controller
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.SampleDataEvent;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import flashx.textLayout.elements.GlobalSettings;
	import flashx.textLayout.formats.Float;
	
	import mx.core.FlexGlobals;
	
	import view.PlayerView;

	public class PlayerController
	{
		private static var _view 			: PlayerView 		= FlexGlobals.topLevelApplication.player;
		
		private static var _pausePoint		: Number			= 0.;
		private static var _playing			: Boolean			= false;
		private static var _currentTrack	: Sound				= null;
		private static var _soundChannel	: SoundChannel		= null;
		private static var _soundTransform	: SoundTransform	= null;
		
		public static function get currentTrack()	: Sound	{ return _currentTrack; }
		
		public static function set pausePoint(value : Number)	: void 	{ _pausePoint = value; }
		
		public static function play() : void
		{
			if (_currentTrack == null)
				return;
			
			if (!_playing )
			{
				_soundChannel =_currentTrack.play(_pausePoint);
				_soundTransform = _soundChannel.soundTransform;
				_currentTrack.addEventListener(SampleDataEvent.SAMPLE_DATA, onProgressHandler);
				
				_view.addEventListener(Event.ENTER_FRAME, onProgressHandler);
				
				_soundTransform.volume = _view.volumeslide.value / 100;
				_soundChannel.soundTransform = _soundTransform;
			}
			else
			{
				_soundChannel.stop();
				
				_view.removeEventListener(Event.ENTER_FRAME, onProgressHandler);
			}
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
				
				_view.removeEventListener(Event.ENTER_FRAME, onProgressHandler);
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
		
		public static function setCurrentTrack(pathName : String) : void
		{
			if (_playing)
				stop();
			
			_currentTrack = new Sound(new URLRequest(pathName));
			_currentTrack.addEventListener(Event.COMPLETE, onCompleteHandler);
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
		
		private static function onCompleteHandler(event : Event) : void
		{
			_view.time.text = "0:00/" + formatNumber(_currentTrack.length);
			_view.trackslide.value = 0.;
			_currentTrack.removeEventListener(Event.COMPLETE, onCompleteHandler);
			play();
		}
	}
}