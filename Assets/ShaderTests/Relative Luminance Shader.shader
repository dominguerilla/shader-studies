// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Relative Luminance Shader" {
	SubShader{

		Pass{
		CGPROGRAM
		#pragma vertex MyVertexProgram
		#pragma fragment MyFragmentProgram

		struct vert_output {
			float4 pos : SV_POSITION;
			float4 col : TEXCOORD0;
		};

		vert_output MyVertexProgram(float4 pos : POSITION) {
			vert_output output;
			output.pos = UnityObjectToClipPos(pos);
			output.col = pos + float4(0.5, 0.5, 0.5, 0.0);
			return output;
		}

		float4 MyFragmentProgram(vert_output input) : SV_TARGET{
			float luminance = 0.21*input.col.r + 0.72*input.col.g + 0.07*input.col.b;
			return float4(luminance, luminance, luminance, 1.0);
		}
		ENDCG
	}
	}
}