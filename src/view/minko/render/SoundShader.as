package view.minko.render
{
	import aerys.minko.render.shader.ActionScriptShader;
	import aerys.minko.render.shader.SValue;
	
	import view.minko.scene.SoundData;

	public class SoundShader extends ActionScriptShader
	{
		private var _pos	: SValue	= null;
		
		override protected function getOutputPosition() : SValue
		{
			var y			: SValue	= multiply(100, absolute(multiply(2., vertexPosition.y)));
			var spectrum	: SValue	= getWorldParameter(256, SoundData, SoundData.SOUND_SPECTRUM);	
			var fqValue		: SValue	= copy(getConstantByIndex(spectrum, y));
			var c			: SValue 	= add(1., fqValue);
			
			_pos = float4(multiply(vertexPosition.x, c.x),
						  multiply(vertexPosition.y, c.x),
						  multiply(vertexPosition.z, c.x),
						  vertexPosition.w);
			
			return multiply4x4(_pos, localToScreenMatrix);
		}
		
		override protected function getOutputColor() : SValue
		{
			var dp3camerapos	: SValue	= negate(dotProduct3(normalize(_pos), cameraLocalDirection));
			var dist			: SValue 	= null;
			var green			: SValue	= null;
			var red				: SValue	= null;
			
			dist = sqrt(add(power(_pos.x, 2.), power(_pos.y, 2), power(_pos.z, 2)));
			red = multiply(2., subtract(dist, .3));
			green = subtract(1.5, dist);
			
			return float4(interpolate(multiply(dp3camerapos, float3(red, green, 0.))), 1.);	
		}
	}
}