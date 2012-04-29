package view.minko.render
{
	import aerys.minko.render.effect.basic.BasicStyle;
	import aerys.minko.render.resource.TextureResource;
	import aerys.minko.render.shader.ActionScriptShader;
	import aerys.minko.render.shader.ActionScriptShaderPart;
	import aerys.minko.render.shader.SValue;
	import aerys.minko.render.shader.node.operation.manipulation.VariadicExtract;
	import aerys.minko.type.math.Vector4;
	
	import view.minko.scene.SoundData;

	public class SoundShader extends ActionScriptShader
	{
		private var _pos	: SValue	= null;
		
		override protected function getOutputPosition() : SValue
		{
			var y			: SValue	= multiply(100, absolute(multiply(2., vertexPosition.y)));
			var spectrum	: SValue	= getWorldParameter(256, SoundData, SoundData.SOUND_SPECTRUM);	
			var fqValue		: SValue	= copy(getConstantByIndex(spectrum, y));
			var c			: SValue 	= multiply(2., add(1., fqValue));
			
			_pos = float4(multiply(vertexPosition.x, c.x),
						  multiply(vertexPosition.y, c.x),
						  multiply(vertexPosition.z, c.x),
						  vertexPosition.w);
			
			return multiply4x4(_pos, localToScreenMatrix);
		}
		
		override protected function getOutputColor() : SValue
		{
			var dp3camerapos	: SValue	= negate(dotProduct3(normalize(_pos), cameraLocalDirection));
			
			return float4(interpolate(multiply(dp3camerapos, float3(0., .5, 0.))), 1.);	
		}
	}
}