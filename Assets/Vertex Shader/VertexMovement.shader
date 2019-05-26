//https://www.febucci.com/2018/10/vertex-shader/
Shader "Custom/VertexMovement" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
	}

		SubShader{
		Tags{ "RenderType" = "Opaque" }

		CGPROGRAM
		//Notice the "vertex:vert" at the end of the next line
#pragma surface surf Standard fullforwardshadows vertex:vert

		sampler2D _MainTex;

	struct Input {
		float2 uv_MainTex;
		float multiplyValue;
	};

	fixed4 _Color;


	void vert(inout appdata_full v, out Input o) {
		float multiplyValue = abs(sin(_Time * 30 + v.vertex.y)) * 1.1; //how much we want to multiply our vertex
		//v.vertex.x *= multiplyValue * v.normal.x;
		v.vertex.z *= multiplyValue; //* v.normal.y;
		UNITY_INITIALIZE_OUTPUT(Input, o);
		o.multiplyValue = multiplyValue;
	}

	void surf(Input IN, inout SurfaceOutputStandard o) {

		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
		o.Albedo = lerp(c.rgb, float3(.3, .3, 1), IN.multiplyValue);

		o.Alpha = c.a;
	}
	ENDCG
	}

		FallBack "Diffuse"
}
