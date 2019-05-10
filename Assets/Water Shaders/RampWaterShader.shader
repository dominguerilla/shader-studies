// https://lindenreid.wordpress.com/2017/12/15/simple-water-shader-in-unity/
Shader "Custom/RampWaterShader"
{
	Properties
	{
		// color of the water
		_Color("Color", Color) = (1, 1, 1, 1)
		
		// color of the edge effect
		// deletion of this was not suggested in the tutorial.

		// width of the edge effect
		_DepthFactor("Depth Factor", float) = 1.0
		// the ramp texture
		// THIS WAS MISSING FROM THE TUTORIAL
		_DepthRampTex("Depth Ramp Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
	{

		CGPROGRAM
		// required to use ComputeScreenPos()
#include "UnityCG.cginc"

#pragma vertex vert
#pragma fragment frag

		// Unity built-in - NOT required in Properties
		sampler2D _CameraDepthTexture;
	float4 _Color;
	float _DepthFactor;
	sampler2D _DepthRampTex;

	struct vertexInput
	{
		float4 vertex : POSITION;
	};

	struct vertexOutput
	{
		float4 pos : SV_POSITION;
		float4 screenPos : TEXCOORD1;
	};

	vertexOutput vert(vertexInput input)
	{
		vertexOutput output;

		// convert obj-space position to camera clip space
		output.pos = UnityObjectToClipPos(input.vertex);

		// compute depth (screenPos is a float4)
		output.screenPos = ComputeScreenPos(output.pos);

		return output;
	}

	float4 frag(vertexOutput input) : COLOR
	{
		// sample camera depth texture
		float4 depthSample = SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, input.screenPos);
		float depth = LinearEyeDepth(depthSample).r;

		// Because the camera depth texture returns a value between 0-1,
		// we can use that value to create a grayscale color
		// to test the value output.
		// THIS WAS CHANGED FROM float4 TO float, WITH NO INDICATION IN THE TUTORIAL.
		float foamLine = 1 - saturate(_DepthFactor * (depth - input.screenPos.w));
		
		// this line from the tutorial isn't working at all...
		//float4 foamRamp = float4(tex2D(_DepthRampTex, float2(foamLine, 0.5)).rgb, 1.0);
		// Shader error in 'Custom/RampWaterShader': incorrect number of arguments to numeric-type constructor at line [above] (on d3d11)

		// sample the ramp texture
		float4 foamRamp = float4(tex2D(_DepthRampTex, float2(foamLine, 0.5)).rgb, 1.0);
		
		// This needs to be a float4, not a float.
		// I got stuck on this, thinking it was supposed to be 'float' instead, for some reason.
		// When you do that, I noticed that changing the _Color (with a _DepthFactor of 1) would make it turn to black as you changed it.
		// The pattern that it did that in was...interesting.
		// Check what happens when you change the _Color to different colors.
		// Then, check what happens when you do the above with a depth factor <= 1.0, and depth factor > 1.0.
		float4 col = _Color * foamRamp;

		// This line is omitted from the tutorial.
		return col;
	}

		ENDCG
	} }}