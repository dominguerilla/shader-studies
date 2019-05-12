Shader "Custom/Undulate" {
	Properties{
		_Color1("Color 1", Color) = (1,1,1,1)
		_Color2("Color 2", Color) = (0, 1, 0, 1)
		_InflateSpeed("Undulate Speed", float) = 30
		_InflateScale("Undulate Scale", float) = 0.25
	}

		SubShader{
		Tags{ "RenderType" = "Opaque" }

		CGPROGRAM
#pragma surface surf Standard fullforwardshadows vertex:vert


	struct Input {
		float2 uv_MainTex;
		float undulateFactor;
	};

	fixed4 _Color1, _Color2;
	float _InflateSpeed, _InflateScale;

	void vert(inout appdata_full v, out Input o) {

		float undulateFactor = (abs(sin(_Time * _InflateSpeed + v.vertex.y)) * _InflateScale);
		v.vertex.z *= 1 + undulateFactor;
		v.vertex.x *= 1 + undulateFactor;
		UNITY_INITIALIZE_OUTPUT(Input, o);
		o.undulateFactor = undulateFactor;
	}

	void surf(Input IN, inout SurfaceOutputStandard o) {

		fixed4 c = _Color1;
		o.Albedo = (c.rgb + _Color2.rgb) * (IN.undulateFactor);
		o.Alpha = 1;
	}
	ENDCG
	}

		FallBack "Diffuse"
}