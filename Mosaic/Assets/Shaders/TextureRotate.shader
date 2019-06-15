﻿Shader "Custom/RotateUVs" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}
		_RotationAngle("RotationAngle", Float) = 2.0
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			#pragma surface surf Lambert vertex:vert

			sampler2D _MainTex;

			struct Input {
				float2 uv_MainTex;
			};
			float PI = 3.14159265358;

			float _RotationAngle;

			void vert(inout appdata_full v) {
				v.texcoord.xy -= 0.5;
				float s = sin(2 * (_RotationAngle * 3.14159265358) / 360);
				float c = cos(2 * (_RotationAngle * 3.14159265358) / 360);
				float2x2 rotationMatrix = float2x2(c, -s, s, c);
				rotationMatrix *= 0.5;
				rotationMatrix += 0.5;
				rotationMatrix = rotationMatrix * 2 - 1;
				v.texcoord.xy = mul(v.texcoord.xy, rotationMatrix);
				v.texcoord.xy += 0.5;
			}

			void surf(Input IN, inout SurfaceOutput o) {
				half4 c = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = c.rgb;
				o.Alpha = c.a;
			}
			ENDCG
		}
			FallBack "Diffuse"
}