Shader "Custom/Two Color Face Shader"
{
    SubShader
    {
        Pass
        {
			Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct vert_in
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 posInObjectCoords : TEXCOORD0;
            };

            v2f vert (vert_in v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.posInObjectCoords = v.vertex;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
				if (i.posInObjectCoords.y > 0.0) {
					discard;
				}
				return float4(0.0, 0.0, 1.0, 1.0);
            }
            ENDCG
        }

		Pass
			{
				Cull Back
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				struct vert_in
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 posInObjectCoords : TEXCOORD0;
			};

			v2f vert(vert_in v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.posInObjectCoords = v.vertex;
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				if (i.posInObjectCoords.y > 0.0) {
					discard;
				}
			return float4(0.0, 1.0, 0.0, 1.0);
			}
				ENDCG
			}
    }
}
