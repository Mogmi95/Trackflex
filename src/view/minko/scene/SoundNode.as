package view.minko.scene
{
	import aerys.minko.scene.data.TransformData;
	import aerys.minko.scene.node.AbstractScene;
	import aerys.minko.type.Factory;
	
	import flash.media.SoundMixer;

	public class SoundNode extends AbstractScene
	{
		protected static const LIGHT_DATA : Factory	= Factory.getFactory(SoundData);
		
		public function SoundNode()
		{
			super();
			
			actions.push(new SoundAction());
		}
		
		public function getSoundData(transformData : TransformData) : SoundData
		{
			var sd : SoundData = LIGHT_DATA.create(true) as SoundData;
			
			return sd;
		}
	}
}