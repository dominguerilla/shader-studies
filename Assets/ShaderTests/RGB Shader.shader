// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/RGB Shader" {
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

			float4 MyFragmentProgram(vert_output input) : SV_TARGET {
				return input.col;
			}
			ENDCG
		}
	}
}