Shader "Custom/Extrude" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
	_Amount("Amount", Range(0,.3)) = .3
	}

		SubShader{
		Tags{ "RenderType" = "Opaque" }

		CGPROGRAM
#pragma surface surf Standard fullforwardshadows vertex:vert

		sampler2D _MainTex;

	struct Input {
		float2 uv_MainTex;
	};

	fixed4 _Color;
	fixed _Amount;

	void vert(inout appdata_full v, out Input o) {

		v.vertex.xyz += (_Amount * v.normal.xyz);
		v.vertex.z *= sin(_Time * 30 + v.vertex.y);
		UNITY_INITIALIZE_OUTPUT(Input, o);

	}

	void surf(Input IN, inout SurfaceOutputStandard o) {

		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
		o.Albedo = c.rgb;
		o.Alpha = c.a;
	}
	ENDCG
	}

		FallBack "Diffuse"
}