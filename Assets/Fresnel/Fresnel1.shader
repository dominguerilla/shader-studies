//http://kylehalladay.com/blog/tutorial/2014/02/18/Fresnel-Shaders-From-The-Ground-Up.html
Shader "Custom/Fresnel1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Scale ("Scale", float) = 1.0
		_Power ("Power", float) = 1.0
		_Color ("Color", color) = (1,1,1,1)
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

            struct vIN
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
            };

            struct vOUT
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
				float R : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST, _Color;
			float _Scale, _Power;

            vOUT vert (vIN v)
            {
                vOUT o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				float3 posWorld = mul(unity_ObjectToWorld, v.vertex).xyz;
				float3 normWorld = normalize(mul(unity_ObjectToWorld, v.normal));

				float3 I = normalize(posWorld - _WorldSpaceCameraPos.xyz);
				o.R = _Scale + pow(1.0 + dot(I, normWorld), _Power);
				return o;
            }

            fixed4 frag (vOUT i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw);
                return lerp(col, _Color, i.R);
            }
            ENDCG
        }
    }
}
