// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JellyFish"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,0)
		_Normal("Normal", 2D) = "bump" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Opacity("Opacity", Range( 0 , 1)) = 1
		_UVOffset0("UVOffset0", Vector) = (0.07,0.1,0.1,0)
		_UVOffset1("UVOffset1", Vector) = (-0.1,-0.1,-0.1,0)
		_CubemapX("CubemapX", CUBE) = "white" {}
		_CubemapY("CubemapY", CUBE) = "white" {}
		_CubemapZ("CubemapZ", CUBE) = "white" {}
		_Amplitude("Amplitude", Float) = 0
		_Frequency("Frequency", Float) = 0
		_TimeOffest("Time Offest", Float) = 0
		_AmplitudeOffset("Amplitude Offset", Float) = 0
		_PositionalOffsetScaler("Positional Offset Scaler", Float) = 0
		_PositionalAmplitydeScaler("Positional Amplityde Scaler", Float) = 0
		_YAmplitude("Y Amplitude", Float) = 0
		_YFrequency("Y Frequency", Float) = 0
		_YTimeOffest("Y Time Offest", Float) = 0
		_YAmplitudeOffset("Y Amplitude Offset", Float) = 0
		_YPositionalOffsetScaler("Y Positional Offset Scaler", Float) = 0
		_YPositionalAmplitydeScaler("Y Positional Amplityde Scaler", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldRefl;
			INTERNAL_DATA
		};

		uniform float _Amplitude;
		uniform float _Frequency;
		uniform float _TimeOffest;
		uniform float _PositionalOffsetScaler;
		uniform float _PositionalAmplitydeScaler;
		uniform float _AmplitudeOffset;
		uniform float _YAmplitude;
		uniform float _YFrequency;
		uniform float _YTimeOffest;
		uniform float _YPositionalOffsetScaler;
		uniform float _YPositionalAmplitydeScaler;
		uniform float _YAmplitudeOffset;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float4 _Color;
		uniform samplerCUBE _CubemapX;
		uniform float3 _UVOffset0;
		uniform samplerCUBE _CubemapY;
		uniform samplerCUBE _CubemapZ;
		uniform float3 _UVOffset1;
		uniform float _Smoothness;
		uniform float _Opacity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_20_0 = ( ( _Amplitude * sin( ( ( _Frequency * _Time.y ) + _TimeOffest + ( ase_vertex3Pos.y * _PositionalOffsetScaler ) ) ) * ( ase_vertex3Pos.y * _PositionalAmplitydeScaler ) ) + _AmplitudeOffset );
			float temp_output_52_0 = (1.0 + (0.0 - ase_vertex3Pos.y) * (0.0 - 1.0) / (1.0 - ase_vertex3Pos.y));
			float4 appendResult22 = (float4(( ase_vertex3Pos.x * temp_output_20_0 ) , ( ( ( _YAmplitude * sin( ( ( _YFrequency * _Time.y ) + _YTimeOffest + ( temp_output_52_0 * _YPositionalOffsetScaler ) ) ) * ( temp_output_52_0 * _YPositionalAmplitydeScaler ) ) + _YAmplitudeOffset ) * ase_vertex3Pos.y ) , ( ase_vertex3Pos.z * temp_output_20_0 ) , 0.0));
			v.vertex.xyz += appendResult22.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode53 = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			o.Normal = tex2DNode53;
			o.Albedo = _Color.rgb;
			float3 newWorldReflection54 = WorldReflectionVector( i , tex2DNode53 );
			float3 appendResult62 = (float3(texCUBE( _CubemapX, ( _UVOffset0 + newWorldReflection54 ) ).r , texCUBE( _CubemapY, newWorldReflection54 ).g , texCUBE( _CubemapZ, ( newWorldReflection54 + _UVOffset1 ) ).b));
			o.Emission = appendResult62;
			o.Metallic = 0.63963;
			o.Smoothness = _Smoothness;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldRefl = -worldViewDir;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
6.4;81.6;1519;714;1879.823;-1002.39;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;32;-1371.819,1120.724;Float;False;992.6456;805.6234;Adding the scaled and offset time value to the vertex's y position;4;47;45;34;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1;-1369.423,-189.2302;Float;False;992.6456;805.6234;Adding the scaled and offset time value to the vertex's y position;4;16;14;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-1266.339,1572.602;Float;False;533;302;Scales Vertex Y Position;4;42;35;52;38;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;3;-1256.794,-90.40037;Float;False;478;329;Scales and Offests Time Input;4;10;8;6;73;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;38;-1254.979,1625.219;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;34;-1259.19,1219.555;Float;False;478;329;Scales and Offests Time Input;4;41;39;36;74;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2;-1263.943,262.6456;Float;False;533;302;Scales Vertex Y Position;3;11;5;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;73;-1212.747,94.21045;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;52;-1055.39,1616.371;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1225.584,-54.95183;Float;False;Property;_Frequency;Frequency;10;0;Create;True;0;0;False;0;0;2.59;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;74;-1225.917,1451.438;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;4;-1240.348,321.9586;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-1227.98,1255.003;Float;False;Property;_YFrequency;Y Frequency;16;0;Create;True;0;0;False;0;0;2.59;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1239.943,478.6455;Float;False;Property;_PositionalOffsetScaler;Positional Offset Scaler;13;0;Create;True;0;0;False;0;0;68.83;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1043.044,1799.472;Float;False;Property;_YPositionalOffsetScaler;Y Positional Offset Scaler;19;0;Create;True;0;0;False;0;0;68.83;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-960.0585,137.7559;Float;False;Property;_TimeOffest;Time Offest;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;40;-1275.222,1992.936;Float;False;626.0944;371.8522;Uses distance form origin as scalar multiplier of amplitude;2;48;44;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;9;-1272.826,682.9802;Float;False;626.0944;371.8522;Uses distance form origin as scalar multiplier of amplitude;2;17;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-962.4536,1447.712;Float;False;Property;_YTimeOffest;Y Time Offest;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-854.472,1662.832;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-910.1346,1282.473;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-907.7395,-27.48212;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-917.3005,327.5116;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-653.7495,81.92506;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;53;495.5627,-1301.626;Float;True;Property;_Normal;Normal;1;0;Create;True;0;0;False;0;None;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-1262.755,898.5991;Float;False;Property;_PositionalAmplitydeScaler;Positional Amplityde Scaler;14;0;Create;True;0;0;False;0;0;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1265.151,2208.555;Float;False;Property;_YPositionalAmplitydeScaler;Y Positional Amplityde Scaler;20;0;Create;True;0;0;False;0;0;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;43;-343.0096,1136.594;Float;False;516.188;327.7604;Scaling and offsetting sin output;4;51;50;49;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-656.1447,1391.881;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;12;-340.6144,-173.3611;Float;False;516.188;327.7604;Scaling and offsetting sin output;4;20;19;18;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-875.2949,2086.293;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;16;-509.8075,99.4813;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-293.0096,1186.594;Float;False;Property;_YAmplitude;Y Amplitude;15;0;Create;True;0;0;False;0;0;21.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-290.6144,-123.3611;Float;False;Property;_Amplitude;Amplitude;9;0;Create;True;0;0;False;0;0;37.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;47;-512.2027,1409.437;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-872.8997,776.3369;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;68;-5.157148,-1181.264;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-177.5631,1379.134;Float;False;Property;_YAmplitudeOffset;Y Amplitude Offset;18;0;Create;True;0;0;False;0;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;54;7.263351,-757.988;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-63.71466,-116.4087;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;55;26.11272,-477.5757;Float;False;Property;_UVOffset1;UVOffset1;5;0;Create;True;0;0;False;0;-0.1,-0.1,-0.1;-0.1,-0.1,-0.1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-66.10981,1193.546;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-174.1679,69.1775;Float;False;Property;_AmplitudeOffset;Amplitude Offset;12;0;Create;True;0;0;False;0;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;56;11.10606,-972.4377;Float;False;Property;_UVOffset0;UVOffset0;4;0;Create;True;0;0;False;0;0.07,0.1,0.1;0.1,0.1,0.1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;20;33.38361,27.08538;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;24;256.3047,-72.46725;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;51;30.98846,1337.041;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;336.2675,-940.8115;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;336.8674,-485.211;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;59;510.0834,-785.3551;Float;True;Property;_CubemapY;CubemapY;7;0;Create;True;0;0;False;0;None;a9f053d430424adb925523ba78342596;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;0,0;False;1;FLOAT3;1,0,0;False;2;FLOAT;1;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;551.9069,-262.909;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;582.1628,194.308;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;21;696.7708,-120.4855;Float;False;245.9668;274.1254;Applying result to x axis;1;22;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;60;511.8677,-583.211;Float;True;Property;_CubemapZ;CubemapZ;8;0;Create;True;0;0;False;0;None;a9f053d430424adb925523ba78342596;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;0,0;False;1;FLOAT3;1,0,0;False;2;FLOAT;1;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;569.5204,-75.91822;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;524.3675,-978.4116;Float;True;Property;_CubemapX;CubemapX;6;0;Create;True;0;0;False;0;None;a9f053d430424adb925523ba78342596;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;0,0;False;1;FLOAT3;1,0,0;False;2;FLOAT;1;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;22;765.6812,-63.8175;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;62;920.3682,-830.3103;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;65;1486.182,-717.0055;Float;False;Property;_Color;Color;0;0;Create;True;0;0;False;0;1,1,1,0;0.8396226,0.8396226,0.8396226,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;63;1154.74,-341.459;Float;False;Constant;_Metallic;Metallic;-1;0;Create;True;0;0;False;0;0.63963;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;1151.37,-240.7238;Float;False;Property;_Smoothness;Smoothness;2;0;Create;True;0;0;False;0;0;0.946;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;1147.798,-145.6574;Float;False;Property;_Opacity;Opacity;3;0;Create;True;0;0;False;0;1;0.403;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1756.93,-353.4446;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;JellyFish;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;52;1;38;2
WireConnection;42;0;52;0
WireConnection;42;1;35;0
WireConnection;41;0;36;0
WireConnection;41;1;74;0
WireConnection;10;0;6;0
WireConnection;10;1;73;0
WireConnection;11;0;4;2
WireConnection;11;1;5;0
WireConnection;14;0;10;0
WireConnection;14;1;8;0
WireConnection;14;2;11;0
WireConnection;45;0;41;0
WireConnection;45;1;39;0
WireConnection;45;2;42;0
WireConnection;48;0;52;0
WireConnection;48;1;44;0
WireConnection;16;0;14;0
WireConnection;47;0;45;0
WireConnection;17;0;4;2
WireConnection;17;1;13;0
WireConnection;68;0;53;0
WireConnection;54;0;68;0
WireConnection;18;0;15;0
WireConnection;18;1;16;0
WireConnection;18;2;17;0
WireConnection;49;0;46;0
WireConnection;49;1;47;0
WireConnection;49;2;48;0
WireConnection;20;0;18;0
WireConnection;20;1;19;0
WireConnection;51;0;49;0
WireConnection;51;1;50;0
WireConnection;58;0;56;0
WireConnection;58;1;54;0
WireConnection;57;0;54;0
WireConnection;57;1;55;0
WireConnection;59;1;54;0
WireConnection;25;0;24;1
WireConnection;25;1;20;0
WireConnection;26;0;24;3
WireConnection;26;1;20;0
WireConnection;60;1;57;0
WireConnection;31;0;51;0
WireConnection;31;1;24;2
WireConnection;61;1;58;0
WireConnection;22;0;25;0
WireConnection;22;1;31;0
WireConnection;22;2;26;0
WireConnection;62;0;61;1
WireConnection;62;1;59;2
WireConnection;62;2;60;3
WireConnection;0;0;65;0
WireConnection;0;1;53;0
WireConnection;0;2;62;0
WireConnection;0;3;63;0
WireConnection;0;4;66;0
WireConnection;0;9;67;0
WireConnection;0;11;22;0
ASEEND*/
//CHKSM=7D20FE1C2C755EFA027DEDB61DB8AE860589DEDF