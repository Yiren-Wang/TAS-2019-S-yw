// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RainDrop"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_TimeScale("TimeScale", Float) = 5
		_FlowStrength("FlowStrength", Float) = 0.075
		_Texture1("Texture 1", 2D) = "white" {}
		_DropDensity("DropDensity", Range( 0 , 1)) = 1
		_Texture2("Texture 2", 2D) = "white" {}
		_DropLoopSpeed("DropLoopSpeed", Float) = 0.15
		_Texture3("Texture 3", 2D) = "white" {}
		_Opacity("Opacity", Range( 0 , 1)) = 1
		_MainTex("MainTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform sampler2D _Texture1;
			uniform float _TimeScale;
			uniform sampler2D _Texture0;
			uniform float _FlowStrength;
			uniform float _DropDensity;
			uniform sampler2D _Texture3;
			uniform sampler2D _Texture2;
			uniform float _DropLoopSpeed;
			uniform float _Opacity;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				float3 vertexValue =  float3(0,0,0) ;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 finalColor;
				float2 uv_MainTex = i.ase_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 uv082 = i.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float mulTime31 = _Time.y * _TimeScale;
				float Time32 = mulTime31;
				float2 uv04 = i.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float4 appendResult7 = (float4(( uv04.x * ( 16.0 / 9.0 ) ) , uv04.y , 0.0 , 0.0));
				float4 UVscale8 = appendResult7;
				float4 tex2DNode11 = tex2D( _Texture0, UVscale8.xy );
				float2 panner27 = ( Time32 * float2( 0,0.025 ) + ( float4( ( (tex2DNode11).rg * _FlowStrength ), 0.0 , 0.0 ) + UVscale8 ).xy);
				float4 tex2DNode36 = tex2D( _Texture1, panner27 );
				float smoothstepResult75 = smoothstep( 0.9 , 1.0 , ( tex2DNode36.b + _DropDensity ));
				float4 appendResult16 = (float4(0.0 , tex2DNode11.g , 0.0 , 0.0));
				float2 panner63 = ( Time32 * float2( 0,0 ) + ( ( appendResult16 * 0.33 ) + UVscale8 ).xy);
				float4 tex2DNode62 = tex2D( _Texture3, panner63 );
				float4 appendResult65 = (float4(tex2DNode62.r , tex2DNode62.g , 0.0 , 0.0));
				float smoothstepResult67 = smoothstep( 0.7 , 1.0 , ( tex2DNode62.b + _DropDensity ));
				float clampResult73 = clamp( smoothstepResult67 , 0.0 , 1.0 );
				float2 panner25 = ( 1.0 * _Time.y * float2( 0,0.1 ) + ( appendResult16 * 0.2 ).xy);
				float4 tex2DNode41 = tex2D( _Texture2, ( UVscale8 + float4( panner25, 0.0 , 0.0 ) ).xy );
				float4 appendResult42 = (float4(tex2DNode41.r , tex2DNode41.g , 0.0 , 0.0));
				float clampResult72 = clamp( ( _DropDensity * 5.0 ) , 0.0 , 1.0 );
				float mulTime44 = _Time.y * _DropLoopSpeed;
				float clampResult58 = clamp( ( ( ( 1.0 - frac( ( ( tex2DNode41.b + frac( mulTime44 ) ) + ( tex2DNode41.b + frac( ( mulTime44 * 0.0 ) ) + 0.5 ) ) ) ) + -0.5 ) * 2.0 ) , 0.0 , 1.0 );
				float4 lerpResult94 = lerp( tex2D( _MainTex, uv_MainTex ) , tex2D( _MainTex, ( float4( uv082, 0.0 , 0.0 ) + float4( ( (tex2DNode36).rg * ( smoothstepResult75 * tex2DNode36.a ) * 0.08 ), 0.0 , 0.0 ) + ( appendResult65 * clampResult73 * 0.08 * tex2DNode62.a * 0.25 ) + ( appendResult42 * 0.08 * clampResult72 * ( tex2DNode41.a * clampResult58 ) ) ).xy ) , _Opacity);
				
				
				finalColor = lerpResult94;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16700
42.4;177.6;1519;572;1714.582;359.2147;1.574978;True;True
Node;AmplifyShaderEditor.CommentaryNode;9;-4174.472,-1055.595;Float;False;1284.141;372.5098;uvScale;7;2;3;4;6;5;7;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-4117.979,-896.2527;Float;False;Constant;_ScreenWidth;ScreenWidth;0;0;Create;True;0;0;False;0;16;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-4105.913,-799.0102;Float;False;Constant;_ScreenHeight;ScreenHeight;0;0;Create;True;0;0;False;0;9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-3914.831,-1005.595;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;5;-3799.561,-872.9949;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-3581.804,-927.0013;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;7;-3328.333,-876.8658;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-3130.333,-836.8657;Float;False;UVscale;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;12;-4622.443,-149.8272;Float;False;8;UVscale;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;10;-4703.087,-441.4001;Float;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;False;0;None;6e5df953f66f9174fbb2cfb003a158b8;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;11;-4398.621,-438.6792;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-4292.948,-250.3344;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;16;-4059.855,-246.0424;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-4026.43,-23.32708;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-3823.207,-42.00172;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-3381.528,701.5168;Float;False;Property;_DropLoopSpeed;DropLoopSpeed;6;0;Create;True;0;0;False;0;0.15;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;-3821.947,-141.8718;Float;False;8;UVscale;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2717.335,-957.9748;Float;False;710.4365;166.8585;Time;3;32;31;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;44;-3154.204,704.3232;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;25;-3666.124,-39.80473;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-2667.335,-907.9748;Float;False;Property;_TimeScale;TimeScale;1;0;Create;True;0;0;False;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-2875.752,831.0853;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-3489.259,-137.572;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;40;-3197.294,421.8013;Float;True;Property;_Texture2;Texture 2;5;0;Create;True;0;0;False;0;None;be13a43498e638c409dea5b8d3f62c92;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-4004.455,-462.1606;Float;False;Property;_FlowStrength;FlowStrength;2;0;Create;True;0;0;False;0;0.075;0.075;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-2683.471,978.7606;Float;False;Constant;_Float3;Float 3;7;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;45;-2873.756,695.2128;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;47;-2637.062,840.6807;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-4054.623,-109.1474;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;0.33;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;-2888.194,419.1426;Float;True;Property;_TextureSample2;Texture Sample 2;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;13;-4013.301,-543.0583;Float;False;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;31;-2452.134,-903.084;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-2246.898,-905.7162;Float;False;Time;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;-2453.419,828.518;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-3692.641,-418.942;Float;False;8;UVscale;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-3690.641,-523.2299;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-2446.653,673.0717;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-3824.623,-246.1475;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-3537.554,-246.6211;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-2245.58,670.8385;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-2910.223,-414.4823;Float;False;32;Time;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-3488.623,-522.8634;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;-3087.826,133.7392;Float;False;32;Time;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;61;-2878.847,-163.5833;Float;True;Property;_Texture3;Texture 3;7;0;Create;True;0;0;False;0;cef3c03eb60d51e4793f64654237487b;cef3c03eb60d51e4793f64654237487b;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FractNode;52;-2086.716,671.5081;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;35;-2760.387,-719.7564;Float;True;Property;_Texture1;Texture 1;3;0;Create;True;0;0;False;0;be13a43498e638c409dea5b8d3f62c92;be13a43498e638c409dea5b8d3f62c92;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.PannerNode;27;-2752.554,-519.6031;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0.025;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;63;-2867.873,92.16241;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1918.859,889.6223;Float;False;Constant;_Float5;Float 5;7;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;53;-1929.716,671.5081;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;62;-2556.067,-163.5833;Float;True;Property;_TextureSample3;Texture Sample 3;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;-1935.926,787.5501;Float;False;Constant;_Float4;Float 4;7;0;Create;True;0;0;False;0;-0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-2914.418,-330.1082;Float;False;Property;_DropDensity;DropDensity;4;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;36;-2501.821,-651.5509;Float;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;38;-2145.893,-487.9299;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-2367.466,332.9146;Float;False;Constant;_Float8;Float 8;8;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-2201.492,219.6335;Float;False;Constant;_Float7;Float 7;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-2150.479,-337.7848;Float;False;Constant;_Float10;Float 10;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-2161.975,-408.0302;Float;False;Constant;_Float9;Float 9;8;0;Create;True;0;0;False;0;0.9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;57;-1664.109,693.011;Float;False;ConstantBiasScale;-1;;1;63208df05c83e8e49a48ffbdce2e43a0;0;3;3;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;66;-2198.808,20.44469;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-2207.991,137.3067;Float;False;Constant;_Float6;Float 6;8;0;Create;True;0;0;False;0;0.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-2187.323,308.5032;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;75;-1952.516,-493.602;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;58;-1384.429,684.7963;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;67;-2009.757,45.23068;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;72;-2003.466,272.9146;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;73;-1803.591,42.74742;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-1835.48,-66.05803;Float;False;Constant;_Float11;Float 11;8;0;Create;True;0;0;False;0;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-1902.79,-294.9635;Float;False;Constant;_RefractionStrength;RefractionStrength;8;0;Create;True;0;0;False;0;0.08;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;65;-2112.283,-277.0782;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;37;-1824.821,-648.5509;Float;False;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-2451.766,444.2706;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-1321.815,530.5425;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-1777.541,-544.6887;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;82;-1399.474,-314.8347;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-1229.236,228.1358;Float;False;4;4;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-1562.929,-613.5895;Float;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-1567.086,-198.296;Float;False;5;5;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;93;-728.1884,-125.8461;Float;True;Property;_MainTex;MainTex;9;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;83;-918.4116,-139.3888;Float;False;4;4;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;92;-420.5696,93.67615;Float;True;Property;_TextureSample5;Texture Sample 5;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;95;-361.1422,318.5532;Float;False;Property;_Opacity;Opacity;8;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;91;-412.5696,-96.32385;Float;True;Property;_TextureSample4;Texture Sample 4;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;94;-77.14221,15.55316;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;96;172.781,22.2147;Float;False;True;2;Float;ASEMaterialInspector;0;1;RainDrop;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;0;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;5;0;2;0
WireConnection;5;1;3;0
WireConnection;6;0;4;1
WireConnection;6;1;5;0
WireConnection;7;0;6;0
WireConnection;7;1;4;2
WireConnection;8;0;7;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;16;0;17;0
WireConnection;16;1;11;2
WireConnection;23;0;16;0
WireConnection;23;1;24;0
WireConnection;44;0;43;0
WireConnection;25;0;23;0
WireConnection;46;0;44;0
WireConnection;26;0;22;0
WireConnection;26;1;25;0
WireConnection;45;0;44;0
WireConnection;47;0;46;0
WireConnection;41;0;40;0
WireConnection;41;1;26;0
WireConnection;13;0;11;0
WireConnection;31;0;29;0
WireConnection;32;0;31;0
WireConnection;49;0;41;3
WireConnection;49;1;47;0
WireConnection;49;2;50;0
WireConnection;14;0;13;0
WireConnection;14;1;15;0
WireConnection;48;0;41;3
WireConnection;48;1;45;0
WireConnection;19;0;16;0
WireConnection;19;1;20;0
WireConnection;21;0;19;0
WireConnection;21;1;22;0
WireConnection;51;0;48;0
WireConnection;51;1;49;0
WireConnection;18;0;14;0
WireConnection;18;1;28;0
WireConnection;52;0;51;0
WireConnection;27;0;18;0
WireConnection;27;1;34;0
WireConnection;63;0;21;0
WireConnection;63;1;64;0
WireConnection;53;0;52;0
WireConnection;62;0;61;0
WireConnection;62;1;63;0
WireConnection;36;0;35;0
WireConnection;36;1;27;0
WireConnection;38;0;36;3
WireConnection;38;1;39;0
WireConnection;57;3;53;0
WireConnection;57;1;54;0
WireConnection;57;2;55;0
WireConnection;66;0;62;3
WireConnection;66;1;39;0
WireConnection;70;0;39;0
WireConnection;70;1;71;0
WireConnection;75;0;38;0
WireConnection;75;1;76;0
WireConnection;75;2;77;0
WireConnection;58;0;57;0
WireConnection;67;0;66;0
WireConnection;67;1;68;0
WireConnection;67;2;69;0
WireConnection;72;0;70;0
WireConnection;73;0;67;0
WireConnection;65;0;62;1
WireConnection;65;1;62;2
WireConnection;37;0;36;0
WireConnection;42;0;41;1
WireConnection;42;1;41;2
WireConnection;59;0;41;4
WireConnection;59;1;58;0
WireConnection;78;0;75;0
WireConnection;78;1;36;4
WireConnection;60;0;42;0
WireConnection;60;1;80;0
WireConnection;60;2;72;0
WireConnection;60;3;59;0
WireConnection;79;0;37;0
WireConnection;79;1;78;0
WireConnection;79;2;80;0
WireConnection;74;0;65;0
WireConnection;74;1;73;0
WireConnection;74;2;80;0
WireConnection;74;3;62;4
WireConnection;74;4;81;0
WireConnection;83;0;82;0
WireConnection;83;1;79;0
WireConnection;83;2;74;0
WireConnection;83;3;60;0
WireConnection;92;0;93;0
WireConnection;92;1;83;0
WireConnection;91;0;93;0
WireConnection;94;0;91;0
WireConnection;94;1;92;0
WireConnection;94;2;95;0
WireConnection;96;0;94;0
ASEEND*/
//CHKSM=8799E48D61EC175429C0B65E0E45932048CF9516