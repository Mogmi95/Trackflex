package view.minko.render
{
	import aerys.minko.render.effect.basic.BasicStyle;
	import aerys.minko.render.resource.TextureResource;
	import aerys.minko.render.shader.ActionScriptShader;
	import aerys.minko.render.shader.SValue;
	import aerys.minko.type.math.Vector4;
	
	import flash.utils.ByteArray;
	
	import view.minko.scene.SoundData;

	public class SoundShader extends ActionScriptShader
	{
		override protected function getOutputPosition() : SValue
		{
			var pos			: SValue	= null;
			var spectrum	: SValue	= getWorldParameter(256, SoundData, SoundData.SOUND_SPECTRUM);

			pos = float4(multiply(vertexPosition.x, spectrum[2]), vertexPosition.y,
						 multiply(vertexPosition.z, spectrum), vertexPosition.w);
			
			return multiply4x4(pos, localToScreenMatrix);
		}
		
		override protected function getOutputColor() : SValue
		{
			var diffuse : SValue	= null;
			
			if (styleIsSet(BasicStyle.DIFFUSE))
			{
				var diffuseStyle	: Object 	= getStyleConstant(BasicStyle.DIFFUSE);
				
				if (diffuseStyle is uint || diffuseStyle is Vector4)
					diffuse = copy(getStyleParameter(4, BasicStyle.DIFFUSE));
				else if (diffuseStyle is TextureResource)
					diffuse = sampleTexture(BasicStyle.DIFFUSE, interpolate(vertexUV));
				else
					throw new Error('Invalid BasicStyle.DIFFUSE value.');
			}
			else
				diffuse = interpolate(vertexRGBColor).rgb;
			
			diffuse.scaleBy(getStyleParameter(4, BasicStyle.DIFFUSE_MULTIPLIER,	0xffffffff));
			
			return float4(multiply(diffuse.rgb, absolute(interpolate(vertexPosition).y)), 1.);
		}
	}
}