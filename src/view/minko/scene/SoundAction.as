package view.minko.scene
{
	import aerys.minko.render.renderer.IRenderer;
	import aerys.minko.scene.action.ActionType;
	import aerys.minko.scene.action.IAction;
	import aerys.minko.scene.data.WorldDataList;
	import aerys.minko.scene.node.IScene;
	import aerys.minko.scene.visitor.ISceneVisitor;
	
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;

	public class SoundAction implements IAction
	{
		private var _array	: ByteArray	= new ByteArray();
		
		public function get type() : uint
		{
			return ActionType.UPDATE_WORLD_DATA;
		}
		
		public function run(scene : IScene, visitor : ISceneVisitor, renderer : IRenderer) : Boolean
		{
			var spectrum	: SoundNode	= SoundNode(scene);
			var data 		: SoundData	= spectrum.getSoundData(visitor.transformData);
			
			SoundMixer.computeSpectrum(_array, true);
			
			var length	: uint	= _array.length / 4 / 2;
			
			data.soundSpectrum ||= new Vector.<Number>(length);
			
			for (var i : uint = 0; i < length; i++)
			{
				var v : Number = (_array.readFloat() + _array.readFloat()) / 2.;
				
				data.soundSpectrum[i] += (v - data.soundSpectrum[i]) * .5;
			}
			
			visitor.worldData[SoundData] = data;
			
			return true;
		}
	}
}