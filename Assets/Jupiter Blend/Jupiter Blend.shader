﻿//http://viclw17.github.io/2018/06/12/GLSL-Practice-With-Shadertoy/
Shader "Unlit/Jupiter Blend"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Speed ("Speed", float) = 1.0
		_Scale ("Scale", float) = 0.002

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

			float _Speed, _Scale;

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
				
				float _Mystery = 0.3f;
				float2 p = i.uv * _Scale;
				for (int i = 1; i < 10; i++) {
					p.x += _Mystery / float(i) * sin(float(i) * 3. * p.y + _Time.x * _Speed);
					p.y += _Mystery / float(i) * cos(float(i) * 3. * p.x + _Time.x * _Speed);
				}
				
				//float r = 1. * .5 + .5;
				float r = cos(p.x + p.y + 1.) * .5 + .5;
				float g = sin(p.x + p.y + 1.) * .5 + .5;
				float b = (sin(p.x + p.y) + cos(p.x + p.y)) * .5 + .5;
				
				return float4(r, g, b, 1.);
            }
            ENDCG
        }
    }
}