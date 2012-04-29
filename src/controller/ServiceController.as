package controller
{
	
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	
	import view.LastfmInfoView;
	import view.LyricsView;
	
	
	public class ServiceController
	{
		
		private static var _infoview        : LastfmInfoView    = FlexGlobals.topLevelApplication.infos ;
		private static var _lyricsview      : LyricsView        = FlexGlobals.topLevelApplication.lyrics;
		
		
		public function ServiceController()
		{
				
		}
		
		public static function updateServiceViewInfos():void{
			var artist : String = PlayerController.currentTrack.id3.artist;
			var song : String = PlayerController.currentTrack.id3.songName;
			_infoview.getArtistInfo(artist);
			_infoview.artistName.text = artist;
			_lyricsview.getArtistSongLyric(artist,song);
			_lyricsview.Title.text = song;
		}
		
		public static function onCompleteHandler(event : Event) : void{
			updateServiceViewInfos();
			PlayerController.currentTrack.removeEventListener(Event.COMPLETE, onCompleteHandler);
		}
	}
}