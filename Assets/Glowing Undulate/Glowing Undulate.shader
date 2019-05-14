Shader "Custom/Glowing Undulate" {
	Properties{
		_Color1("Albedo", Color) = (1,1,1,1)
		_Color2("Glow", Color) = (0, 1, 0, 1)
		_EmissiveFactor("Glow Strength", float) = 0.5
		_Frequency("Frequency", float) = 30
		_Amplitude("Amplitude", float) = 0.25
	}

		SubShader{
		Tags{ 
			"RenderType" = "Opaque" 
			"DisableBatching" = "True" 
		}

		CGPROGRAM
#pragma surface surf Standard fullforwardshadows vertex:vert


	struct Input {
		float2 uv_MainTex;
		float undulateFactor;
	};

	fixed4 _Color1, _Color2;
	float _Frequency, _Amplitude;
	float _EmissiveFactor;

	void vert(inout appdata_full v, out Input o) {

		float undulateFactor = (abs(sin(_Time.y * _Frequency + v.vertex.y)));
		v.vertex.z *= 1 + undulateFactor * _Amplitude;
		v.vertex.x *= 1 + undulateFactor * _Amplitude;
		UNITY_INITIALIZE_OUTPUT(Input, o);
		o.undulateFactor = undulateFactor;
	}

	void surf(Input IN, inout SurfaceOutputStandard o) {

		fixed4 c = _Color1;
		o.Albedo = lerp(c.rgb, _Color2.rgb, IN.undulateFactor);
		o.Emission = _Color2.rgb * IN.undulateFactor * _EmissiveFactor;
		o.Alpha = 1;
	}
	ENDCG
	}

		FallBack "Diffuse"
}