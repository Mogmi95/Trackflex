package controller
{
	
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	import mx.events.IndexChangedEvent;
	
	import view.LastfmInfoView;
	import view.LyricsView;
	
	
	public class ServiceController
	{
		
		private static var _infoview        : LastfmInfoView    = FlexGlobals.topLevelApplication.infos ;
		private static var _lyricsview      : LyricsView        = FlexGlobals.topLevelApplication.lyrics;
		private static var _selectedTab 	: int 				= 0;
		
		
		public function ServiceController()
		{
				
		}
		
		public static function setSelectedTab(index:int):void{
			_selectedTab = index;
		}
		
		public static function updateTabInfos():void{
		if (_selectedTab == 0)
			updateViewInfos();
		else
			updateViewLyric();	
		}
		
		public static function updateViewLyric():void{
			
			if ((PlayerController.currentTrack != null)  && (FlexGlobals.topLevelApplication.lyrics != null))
			{
				var artist : String = PlayerController.currentTrack.id3.artist;
				var song : String = PlayerController.currentTrack.id3.songName;
				
				FlexGlobals.topLevelApplication.lyrics.getArtistSongLyric(artist,song);
				FlexGlobals.topLevelApplication.lyrics.Title.text =  song;
				
			}
		}
		public static function clearInfos():void{
		
		
		}
		public static function updateViewInfos():void{
			if ((PlayerController.currentTrack != null) && (FlexGlobals.topLevelApplication.infos != null))
			{
				var artist : String = PlayerController.currentTrack.id3.artist;
				FlexGlobals.topLevelApplication.infos.getArtistInfo(artist);
				FlexGlobals.topLevelApplication.infos.artistName.text = artist;
			}
		}
		
		public static function handleChangeTab(index:int):void{
			setSelectedTab(index);
			
			if(_selectedTab == 0){
				updateViewInfos();
			}
			else {
				updateViewLyric();
			}
		}
	}
}