//http://viclw17.github.io/2018/06/12/GLSL-Practice-With-Shadertoy/
Shader "Unlit/Jupiter Blend"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Speed ("Speed", float) = 1.0
		_Scale ("Scale", float) = 0.002
		// I have no idea how to describe this variable, so I chose the closest word I could think of.
		_Blendiness ("Blendiness", float) = 0.5
		_Mystery ("Mystery", float) = 3.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

			float _Speed, _Scale, _Blendiness, _Mystery;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
				
				float2 p = i.uv * _Scale;

				// This part adds octaves of values to the pixel value.
				// Reducing the loop count results in a 'lower resolution' output
				// Increasing the loop count increases the 'resolution'
				// In the original shader, _Blendiness is set to 0.3...what is this called?
				// Playing around with _Blendiness's value has interesting results.
				for (int i = 1; i < 10; i++) {
					p.x += _Blendiness / float(i) * sin(float(i) * _Mystery * p.y + _Time.x * _Speed);
					p.y += _Blendiness / float(i) * cos(float(i) * _Mystery * p.x + _Time.x * _Speed);
				}
				
				// I think the multiplication and addition of the .5 is to clamp the values between 0 and 1;
				// I'm not sure what the purpose of the addition of 1. in the R and G calculation is for though...
				// I reached out to the author for clarification. In the meantime, I can experiment with these values.
				float r = cos(p.x + p.y + 1.) * .5 + .5;
				float g = sin(p.x + p.y + 1.) * .5 + .5;
				float b = (sin(p.x + p.y) + cos(p.x + p.y)) * .5 + .5;
				
				return float4(r, g, b, 1.);
            }
            ENDCG
        }
    }
}
