Shader "Midterm/ToonShader"
{
    Properties
    {
        _Color ("Base Color", Color) = (1,1,1,1)
        _ToonRampTex ("Ramp Texure", 2D) = "white" {}
        _RimColor("Rim Color", Color) = (1,1,1)
        _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
        
    }
    SubShader
    {
        Tags {"Queue" = "Transparent"}

        Pass{
            ZWrite On
            ColorMask 0
            }

        CGPROGRAM
        #pragma surface surf ToonRamp //alpha:fade

        float4 _Color;
        sampler2D _ToonRampTex;

        float4 _RimColor;
        float _RimPower;

        float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            float diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float rh = h;
            float3 ramp = tex2D(_ToonRampTex, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * ramp;
            c.a = s.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
            // half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            // o.Emission = _RimColor.rgb * pow(rim, _RimPower) * 10;
            // o.Alpha = pow(rim, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
