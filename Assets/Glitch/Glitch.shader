Shader "Custom/Glitch"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_GlitchTex("Glitch Texture", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows
		#pragma vertex vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex, _GlitchTex;
		float4 _GlitchTex_ST;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;

		void vert(inout appdata_full v, out Input o) {
			float shift = tex2Dlod(_GlitchTex, float4(_GlitchTex_ST.xy * v.vertex.xy, 0, 0)).r;
			v.vertex.x += shift;
			UNITY_INITIALIZE_OUTPUT(Input, o);
		}

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
