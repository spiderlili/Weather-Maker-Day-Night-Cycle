// Unlit alpha-blended shader.
// - no lighting
// - no lightmap support
// - no per-material color

Shader "Custom/Lightning Flash (Single Pixel PostProcess)" {
Properties 
{
    _Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
}

SubShader {
    Tags {"Queue"="Overlay" "IgnoreProjector"="True" "RenderType"="Transparent"} // Overlay to draw on top of everything
    LOD 100

    Cull Off
    ZTest Always
    ZWrite Off
    //Blend One One
    Blend One SrcAlpha

    Pass {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0

            #include "UnityCG.cginc"

            fixed4 _Color;

            struct appdata_t {
                float4 vertex : POSITION;
                // float2 texcoord : TEXCOORD0;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                // float2 texcoord : TEXCOORD0;
            };

            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = float4(v.vertex.x * 2.0, v.vertex.y * 2.0, 1.0 , 1.0);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return _Color;
            }
        ENDCG
    }
}

}
