package view.minko.scene
{
	import aerys.minko.scene.data.IWorldData;
	import aerys.minko.scene.data.StyleData;
	import aerys.minko.scene.data.TransformData;
	
	import flash.utils.Dictionary;

	public class SoundData implements IWorldData
	{
		public static const SOUND_SPECTRUM	: String = 'soundSpectrum';
		
		protected var _styleStack		: StyleData;
		protected var _transformData	: TransformData;
		protected var _worldData		: Object;
		
		private var _soundSpectrum		: Vector.<Number>	= null;
		
		
		public function set soundSpectrum(value:Vector.<Number>):void
		{
			_soundSpectrum = value;
		}

		public function get soundSpectrum() : Vector.<Number>
		{
			return _soundSpectrum;
		}

		public function SoundData()
		{
			reset();
		}
		
		public final function setDataProvider(styleStack	: StyleData,
											  transformData	: TransformData,
											  worldData		: Dictionary) : void
		{
			_styleStack	= styleStack;
			_transformData	= transformData;
			_worldData	= worldData;
		}
		
		public final function invalidate() : void
		{
		}
		
		public final function reset() : void
		{
		}
	}
}