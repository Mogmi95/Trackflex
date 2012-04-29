package model
{
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.controls.Label;
	
	public class Album
	{
		public var name:String;
		public var artist:String;
		public var img:String;
		public var tracks:ArrayCollection;
		
		public function Album(name:String, artist:String, img:String, tracks:ArrayCollection)
		{
			this.name = name;
			this.artist = artist;
			this.img = img;
			this.tracks = tracks;
		}
	}
}