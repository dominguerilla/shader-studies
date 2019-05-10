// https://lindenreid.wordpress.com/2017/12/15/simple-water-shader-in-unity/
Shader "Custom/FlatWaterShader"
{
	Properties
	{
		// color of the water
		_Color("Color", Color) = (1, 1, 1, 1)
		// color of the edge effect
		_EdgeColor("Edge Color", Color) = (1, 1, 1, 1)
		// width of the edge effect
		_DepthFactor("Depth Factor", float) = 1.0
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
	float4 _EdgeColor;
	float _DepthFactor;

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
		float4 foamLine = 1 - saturate(_DepthFactor * (depth - input.screenPos.w));

		float4 col = _Color + foamLine * _EdgeColor;

		// this was omitted from the tutorial.
		return col;
	}

		ENDCG
	} }}