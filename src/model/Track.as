package model
{
	public class Track
	{
		public var name:String;
		public var artist:String;
		public var number:int;
		public var album:String;
		public var length:String;
				
		public function Track(name:String, artist:String, number:int, album:String, length:String){
			this.name = name;
			this.artist = artist;
			this.number = number;
			this.album = album;
			this.length = length;
		}
	}
}