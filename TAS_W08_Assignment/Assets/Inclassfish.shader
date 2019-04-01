// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Inclassfish"
{
	Properties
	{
		_Amplitude("Amplitude", Float) = 0
		_Frequency("Frequency", Float) = 0
		_TimeOffest("Time Offest", Float) = 0
		_PositionalOffsetScaler("Positional Offset Scaler", Float) = 0
		_PositionalAmplitydeScaler("Positional Amplityde Scaler", Float) = 0
		_AmplitudeOffset("Amplitude Offset", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float _Amplitude;
		uniform float _Frequency;
		uniform float _TimeOffest;
		uniform float _PositionalOffsetScaler;
		uniform float _PositionalAmplitydeScaler;
		uniform float _AmplitudeOffset;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float4 appendResult13 = (float4(( ( _Amplitude * sin( ( ( _Frequency * _Time.y ) + _TimeOffest + ( ase_vertex3Pos.z * _PositionalOffsetScaler ) ) ) * ( ase_vertex3Pos.z * _PositionalAmplitydeScaler ) ) + _AmplitudeOffset ) , 0.0 , 0.0 , 0.0));
			v.vertex.xyz += appendResult13.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
6.4;22.4;1523;774;2691.171;-161.0829;1.520944;True;True
Node;AmplifyShaderEditor.CommentaryNode;20;-1834.548,-176.122;Float;False;992.6456;805.6234;Adding the scaled and offset time value to the vertex's y position;4;4;8;18;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;18;-1729.068,275.7538;Float;False;533;302;Scales Vertex Y Position;3;17;15;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;19;-1721.919,-77.29217;Float;False;478;329;Scales and Offests Time Input;4;7;10;9;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;15;-1705.472,335.0668;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-1705.068,491.7537;Float;False;Property;_PositionalOffsetScaler;Positional Offset Scaler;4;0;Create;True;0;0;False;0;0;19.88;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1690.709,-41.84363;Float;False;Property;_Frequency;Frequency;2;0;Create;True;0;0;False;0;0;7.59;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2;-1683.577,43.41246;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1425.183,150.8641;Float;False;Property;_TimeOffest;Time Offest;3;0;Create;True;0;0;False;0;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1633.924,767.6073;Float;False;626.0944;371.8522;Uses distance form origin as scalar multiplier of amplitude;2;23;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1372.864,-14.37392;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1382.425,340.6198;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;21;-805.7389,-160.2529;Float;False;516.188;327.7604;Scaling and offsetting sin output;4;5;11;6;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1623.852,983.2261;Float;False;Property;_PositionalAmplitydeScaler;Positional Amplityde Scaler;5;0;Create;True;0;0;False;0;0;6.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-1118.874,95.03326;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-755.7389,-110.2529;Float;False;Property;_Amplitude;Amplitude;1;0;Create;True;0;0;False;0;0;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;4;-974.932,112.5895;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1233.997,860.9639;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-528.8392,-103.3005;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-639.2924,82.2857;Float;False;Property;_AmplitudeOffset;Amplitude Offset;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-431.7409,40.19358;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;22;-244.5371,-128.232;Float;False;245.9668;274.1254;Applying result to x axis;1;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-175.6268,-71.564;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;1;-368.2018,479.5233;Float;False;Property;_VertexOffset;VertexOffset;0;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexColorNode;26;-2075.124,752.334;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;198.4253,-4.480909;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Inclassfish;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;9;0
WireConnection;10;1;2;0
WireConnection;16;0;15;3
WireConnection;16;1;17;0
WireConnection;8;0;10;0
WireConnection;8;1;7;0
WireConnection;8;2;16;0
WireConnection;4;0;8;0
WireConnection;23;0;15;3
WireConnection;23;1;24;0
WireConnection;6;0;5;0
WireConnection;6;1;4;0
WireConnection;6;2;23;0
WireConnection;12;0;6;0
WireConnection;12;1;11;0
WireConnection;13;0;12;0
WireConnection;0;11;13;0
ASEEND*/
//CHKSM=0DE50EC2632A965B7B8847CB5C5F492D7B515148