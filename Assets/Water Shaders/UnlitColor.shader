// The normal Unity unlit shader did not write to the depth buffer, so the CorrectWaterShader wasn't able to show the ramp texture where objects are submerged.
// This one fixes that by adding Fallback "Diffuse" at the bottom.
// I also changed it so that it takes a Color instead of a texture.
Shader "Unlit/UnlitColor"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1) 
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
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = _Color;
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
		
    }
	Fallback "Diffuse"
}
