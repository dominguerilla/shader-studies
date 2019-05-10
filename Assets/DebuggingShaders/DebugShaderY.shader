// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/DebugShaderY" {
	SubShader{
		Pass{
		CGPROGRAM

#pragma vertex vert  
#pragma fragment frag 
#include "UnityCG.cginc"

		struct vertexOutput {
		float4 pos : SV_POSITION;
		float4 col : TEXCOORD0;
	};

	vertexOutput vert(appdata_full input)
	{
		vertexOutput output;

		output.pos = UnityObjectToClipPos(input.vertex);
		output.col = float4(0.0, input.texcoord.y, 0.0, 1.0);

		return output;
	}

	float4 frag(vertexOutput input) : COLOR
	{
		return input.col;
	}

		ENDCG
	}
	}
}