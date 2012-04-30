package controller
{
	
	import flash.events.Event;
	import mx.events.IndexChangedEvent; 
	
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
			if (PlayerController.currentTrack != null)
			{
				var artist : String = PlayerController.currentTrack.id3.artist;
		
				_infoview.getArtistInfo(artist);
				_infoview.artistName.text = artist;
			}			
		}
		
		public static function showLyric():void{
			if (PlayerController.currentTrack != null)
			{
				var artist : String = PlayerController.currentTrack.id3.artist;
				var song : String = PlayerController.currentTrack.id3.songName;
				
				_lyricsview.getArtistSongLyric(artist,song);
			}
		}
		
		public static function handleChangeTab(event:IndexChangedEvent):void{
			var currentIndex:int=event.newIndex; 
			
			if (currentIndex == 1){
				showLyric();
			}
		
		}
		
		public static function onCompleteHandler(event : Event) : void{
			updateServiceViewInfos();
			PlayerController.currentTrack.removeEventListener(Event.COMPLETE, onCompleteHandler);
		}
	}
}