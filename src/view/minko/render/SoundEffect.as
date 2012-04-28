package view.minko.render
{
	import aerys.minko.render.RenderTarget;
	import aerys.minko.render.effect.IRenderingEffect;
	import aerys.minko.render.effect.SinglePassEffect;
	import aerys.minko.render.renderer.RendererState;
	import aerys.minko.scene.data.StyleData;
	import aerys.minko.scene.data.TransformData;
	import aerys.minko.type.enum.Blending;
	
	import flash.utils.Dictionary;

	public class SoundEffect extends SinglePassEffect implements IRenderingEffect
	{
		private static const SOUND_SHADER			: SoundShader	= new SoundShader();
		
		public function SoundEffect(priority		: Number		= 0,
									renderTarget	: RenderTarget	= null)
		{
			super(SOUND_SHADER, priority, renderTarget);
		}
		
		override public function fillRenderState(state		: RendererState,
												 style		: StyleData,
												 transform	: TransformData,
												 world		: Dictionary) : Boolean
		{
			super.fillRenderState(state, style, transform, world);
			
			state.priority	= state.priority + .5;
			
			if (state.blending != Blending.NORMAL)
				state.priority -= .5;
			
			return true;
		}
	}
}