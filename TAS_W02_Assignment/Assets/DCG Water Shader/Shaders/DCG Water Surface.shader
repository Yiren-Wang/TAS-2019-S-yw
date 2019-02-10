// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.37 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.37;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:150,qpre:2,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:True,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34173,y:32434,varname:node_3138,prsc:2|normal-4966-OUT,emission-7143-OUT,custl-857-OUT,alpha-1940-OUT,refract-2364-OUT,voffset-5362-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:9128,x:31948,y:32428,ptovrint:False,ptlb:Water Map,ptin:_WaterMap,varname:node_9128,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:True,tagnrm:False,tex:c781c1bb94fb0e944a34efb2d15461bf,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:5942,x:32385,y:32363,varname:node_5942,prsc:2,tex:c781c1bb94fb0e944a34efb2d15461bf,ntxv:0,isnm:False|UVIN-9462-UVOUT,TEX-9128-TEX;n:type:ShaderForge.SFN_ComponentMask,id:6062,x:32725,y:32326,varname:node_6062,prsc:2,cc1:0,cc2:2,cc3:1,cc4:-1|IN-5723-OUT;n:type:ShaderForge.SFN_RemapRange,id:6897,x:33230,y:32232,varname:node_6897,prsc:2,frmn:0,frmx:1,tomn:-0.3,tomx:1|IN-6222-OUT;n:type:ShaderForge.SFN_Append,id:7126,x:33495,y:32289,varname:node_7126,prsc:2|A-451-OUT,B-884-OUT;n:type:ShaderForge.SFN_Vector1,id:884,x:33495,y:32214,varname:node_884,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:5362,x:33325,y:33332,varname:node_5362,prsc:2|A-3826-OUT,B-2629-OUT,C-7225-OUT;n:type:ShaderForge.SFN_NormalVector,id:7225,x:33325,y:33479,prsc:2,pt:True;n:type:ShaderForge.SFN_Tex2d,id:9402,x:32385,y:32491,varname:node_9402,prsc:2,tex:c781c1bb94fb0e944a34efb2d15461bf,ntxv:0,isnm:False|UVIN-8281-UVOUT,TEX-9128-TEX;n:type:ShaderForge.SFN_Lerp,id:5723,x:32725,y:32479,varname:node_5723,prsc:2|A-5942-RGB,B-9402-RGB,T-4724-OUT;n:type:ShaderForge.SFN_Append,id:6222,x:33003,y:32278,varname:node_6222,prsc:2|A-6062-R,B-6062-G;n:type:ShaderForge.SFN_FragmentPosition,id:3319,x:31215,y:31523,varname:node_3319,prsc:2;n:type:ShaderForge.SFN_ComponentMask,id:9191,x:31444,y:31523,varname:node_9191,prsc:2,cc1:0,cc2:2,cc3:-1,cc4:-1|IN-3319-XYZ;n:type:ShaderForge.SFN_Multiply,id:4042,x:31968,y:31539,varname:node_4042,prsc:2|A-3355-OUT,B-9821-X,C-3103-OUT;n:type:ShaderForge.SFN_Vector1,id:3103,x:31968,y:31455,varname:node_3103,prsc:2,v1:0.0015;n:type:ShaderForge.SFN_Panner,id:9462,x:32697,y:31760,varname:node_9462,prsc:2,spu:1,spv:1|UVIN-4042-OUT,DIST-5521-OUT;n:type:ShaderForge.SFN_Panner,id:8281,x:32697,y:31902,varname:node_8281,prsc:2,spu:-1,spv:-1|UVIN-5755-OUT,DIST-5521-OUT;n:type:ShaderForge.SFN_Multiply,id:4809,x:31968,y:31672,varname:node_4809,prsc:2|A-4042-OUT,B-1699-OUT;n:type:ShaderForge.SFN_Vector1,id:1699,x:31782,y:31693,varname:node_1699,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Add,id:5755,x:31968,y:31801,varname:node_5755,prsc:2|A-4809-OUT,B-6173-OUT;n:type:ShaderForge.SFN_Vector2,id:6173,x:31782,y:31759,varname:node_6173,prsc:2,v1:0.333,v2:0.666;n:type:ShaderForge.SFN_Time,id:4898,x:31782,y:31974,varname:node_4898,prsc:2;n:type:ShaderForge.SFN_Multiply,id:5521,x:31968,y:31974,varname:node_5521,prsc:2|A-4898-TSL,B-9821-Y,C-2299-OUT;n:type:ShaderForge.SFN_Vector1,id:2299,x:31794,y:32212,varname:node_2299,prsc:2,v1:0.3;n:type:ShaderForge.SFN_LightVector,id:9539,x:30943,y:33601,varname:node_9539,prsc:2;n:type:ShaderForge.SFN_ViewReflectionVector,id:3268,x:30943,y:33741,varname:node_3268,prsc:2;n:type:ShaderForge.SFN_Dot,id:9896,x:31145,y:33601,varname:node_9896,prsc:2,dt:1|A-9539-OUT,B-3268-OUT;n:type:ShaderForge.SFN_Power,id:3122,x:31319,y:33601,varname:node_3122,prsc:2|VAL-9896-OUT,EXP-8002-OUT;n:type:ShaderForge.SFN_Slider,id:4690,x:30768,y:34002,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_4690,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8,max:1;n:type:ShaderForge.SFN_RemapRange,id:3715,x:31254,y:34037,varname:node_3715,prsc:2,frmn:0,frmx:1,tomn:1,tomx:11|IN-4690-OUT;n:type:ShaderForge.SFN_Exp,id:8002,x:31418,y:34037,varname:node_8002,prsc:2,et:1|IN-3715-OUT;n:type:ShaderForge.SFN_Multiply,id:2143,x:31935,y:33588,varname:node_2143,prsc:2|A-5090-OUT,B-4092-OUT,C-5984-OUT;n:type:ShaderForge.SFN_Relay,id:2593,x:33011,y:33255,varname:node_2593,prsc:2|IN-6062-B;n:type:ShaderForge.SFN_OneMinus,id:6118,x:31656,y:31555,varname:node_6118,prsc:2|IN-9191-G;n:type:ShaderForge.SFN_Append,id:3355,x:31704,y:31427,varname:node_3355,prsc:2|A-9191-R,B-6118-OUT;n:type:ShaderForge.SFN_Multiply,id:4582,x:31650,y:34037,varname:node_4582,prsc:2|A-8002-OUT,B-1293-OUT;n:type:ShaderForge.SFN_Power,id:2916,x:31319,y:33725,varname:node_2916,prsc:2|VAL-9896-OUT,EXP-4582-OUT;n:type:ShaderForge.SFN_Multiply,id:7396,x:31650,y:34162,varname:node_7396,prsc:2|A-8002-OUT,B-7979-OUT;n:type:ShaderForge.SFN_Vector1,id:1293,x:31422,y:34215,varname:node_1293,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Vector1,id:7979,x:31422,y:34303,varname:node_7979,prsc:2,v1:0.025;n:type:ShaderForge.SFN_Power,id:4729,x:31319,y:33858,varname:node_4729,prsc:2|VAL-9896-OUT,EXP-7396-OUT;n:type:ShaderForge.SFN_Multiply,id:3891,x:31667,y:33713,varname:node_3891,prsc:2|A-2916-OUT,B-3413-OUT,C-9819-OUT;n:type:ShaderForge.SFN_Multiply,id:1551,x:31687,y:33858,varname:node_1551,prsc:2|A-4729-OUT,B-4322-OUT,C-9819-OUT;n:type:ShaderForge.SFN_Vector1,id:3413,x:31490,y:33791,varname:node_3413,prsc:2,v1:0.13;n:type:ShaderForge.SFN_Add,id:5090,x:31637,y:33584,varname:node_5090,prsc:2|A-3122-OUT,B-1551-OUT,C-3891-OUT;n:type:ShaderForge.SFN_Vector1,id:4322,x:31468,y:33892,varname:node_4322,prsc:2,v1:0.07;n:type:ShaderForge.SFN_Depth,id:4551,x:31031,y:34570,varname:node_4551,prsc:2;n:type:ShaderForge.SFN_SceneDepth,id:2638,x:31031,y:34437,varname:node_2638,prsc:2;n:type:ShaderForge.SFN_Subtract,id:2839,x:31199,y:34437,varname:node_2839,prsc:2|A-2638-OUT,B-4551-OUT;n:type:ShaderForge.SFN_Multiply,id:7378,x:31199,y:34570,varname:node_7378,prsc:2|A-2839-OUT,B-6001-OUT;n:type:ShaderForge.SFN_Slider,id:6001,x:31031,y:34728,ptovrint:False,ptlb:Water Density,ptin:_WaterDensity,varname:node_6001,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2,max:1;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:8404,x:31455,y:34572,varname:node_8404,prsc:2|IN-7378-OUT,IMIN-5700-OUT,IMAX-1324-OUT,OMIN-9205-OUT,OMAX-6043-OUT;n:type:ShaderForge.SFN_Vector1,id:5700,x:31455,y:34696,varname:node_5700,prsc:2,v1:-0.1;n:type:ShaderForge.SFN_Vector1,id:9205,x:31455,y:34507,varname:node_9205,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:6043,x:31455,y:34454,varname:node_6043,prsc:2,v1:0;n:type:ShaderForge.SFN_Color,id:3221,x:31031,y:34829,ptovrint:False,ptlb:Water Color,ptin:_WaterColor,varname:node_3221,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.7867647,c2:0.9647059,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:1324,x:31208,y:34829,varname:node_1324,prsc:2|A-3221-RGB,B-6987-OUT;n:type:ShaderForge.SFN_Vector1,id:6987,x:31031,y:34970,varname:node_6987,prsc:2,v1:8;n:type:ShaderForge.SFN_Clamp01,id:9420,x:31626,y:34572,varname:node_9420,prsc:2|IN-8404-OUT;n:type:ShaderForge.SFN_Power,id:9679,x:31793,y:34572,varname:node_9679,prsc:2|VAL-9420-OUT,EXP-6592-OUT;n:type:ShaderForge.SFN_Vector1,id:6592,x:31626,y:34696,varname:node_6592,prsc:2,v1:4;n:type:ShaderForge.SFN_Multiply,id:3347,x:31973,y:34572,varname:node_3347,prsc:2|A-9679-OUT,B-302-RGB;n:type:ShaderForge.SFN_SceneColor,id:302,x:31973,y:34709,varname:node_302,prsc:2;n:type:ShaderForge.SFN_Add,id:4017,x:32900,y:33930,varname:node_4017,prsc:2|A-3347-OUT,B-2143-OUT,C-9-OUT,D-1764-OUT;n:type:ShaderForge.SFN_Relay,id:2056,x:32450,y:33664,varname:node_2056,prsc:2|IN-1324-OUT;n:type:ShaderForge.SFN_Multiply,id:9,x:32453,y:33988,varname:node_9,prsc:2|A-5487-OUT,B-7507-OUT,C-4332-OUT;n:type:ShaderForge.SFN_Vector1,id:7507,x:32148,y:34021,varname:node_7507,prsc:2,v1:0.02;n:type:ShaderForge.SFN_DepthBlend,id:4332,x:32453,y:34132,varname:node_4332,prsc:2|DIST-9464-OUT;n:type:ShaderForge.SFN_Vector1,id:9464,x:32453,y:34289,varname:node_9464,prsc:2,v1:9;n:type:ShaderForge.SFN_Multiply,id:1764,x:33089,y:33526,varname:node_1764,prsc:2|A-5487-OUT,B-590-OUT,C-3989-OUT,D-4033-OUT;n:type:ShaderForge.SFN_Dot,id:7669,x:31973,y:32944,varname:node_7669,prsc:2,dt:1|A-8010-OUT,B-9624-OUT;n:type:ShaderForge.SFN_LightVector,id:8010,x:31757,y:32944,varname:node_8010,prsc:2;n:type:ShaderForge.SFN_HalfVector,id:9624,x:31757,y:33104,varname:node_9624,prsc:2;n:type:ShaderForge.SFN_RemapRange,id:5985,x:32407,y:32944,varname:node_5985,prsc:2,frmn:0,frmx:1,tomn:-0.6,tomx:1|IN-4310-OUT;n:type:ShaderForge.SFN_Clamp01,id:9573,x:32675,y:32953,varname:node_9573,prsc:2|IN-5985-OUT;n:type:ShaderForge.SFN_OneMinus,id:4310,x:32168,y:32944,varname:node_4310,prsc:2|IN-7669-OUT;n:type:ShaderForge.SFN_Multiply,id:3989,x:32790,y:33351,varname:node_3989,prsc:2|A-9573-OUT,B-6556-OUT,C-1476-OUT;n:type:ShaderForge.SFN_RemapRange,id:2277,x:32513,y:33235,varname:node_2277,prsc:2,frmn:0,frmx:1,tomn:-0.1,tomx:1.3|IN-2593-OUT;n:type:ShaderForge.SFN_Clamp01,id:6556,x:32513,y:33100,varname:node_6556,prsc:2|IN-2277-OUT;n:type:ShaderForge.SFN_Dot,id:2837,x:31997,y:33204,varname:node_2837,prsc:2,dt:1|A-8010-OUT,B-7036-OUT;n:type:ShaderForge.SFN_NormalVector,id:7036,x:31757,y:33261,prsc:2,pt:True;n:type:ShaderForge.SFN_OneMinus,id:4265,x:32168,y:33117,varname:node_4265,prsc:2|IN-2837-OUT;n:type:ShaderForge.SFN_RemapRange,id:2379,x:32166,y:33298,varname:node_2379,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-4265-OUT;n:type:ShaderForge.SFN_Clamp01,id:1476,x:32354,y:33329,varname:node_1476,prsc:2|IN-2379-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:7795,x:33404,y:31501,ptovrint:False,ptlb:ReflectionTex,ptin:_ReflectionTex,varname:node_7795,glob:False,taghide:True,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:5214,x:33946,y:31235,varname:node_5214,prsc:2,ntxv:0,isnm:False|UVIN-3958-OUT,TEX-7795-TEX;n:type:ShaderForge.SFN_ScreenPos,id:5419,x:33370,y:31133,varname:node_5419,prsc:2,sctp:2;n:type:ShaderForge.SFN_Multiply,id:7143,x:34059,y:31529,varname:node_7143,prsc:2|A-6522-OUT,B-3712-OUT,C-5568-OUT;n:type:ShaderForge.SFN_Fresnel,id:5568,x:34059,y:31661,varname:node_5568,prsc:2|NRM-7873-OUT,EXP-5715-OUT;n:type:ShaderForge.SFN_NormalVector,id:7873,x:33799,y:31720,prsc:2,pt:True;n:type:ShaderForge.SFN_Lerp,id:4966,x:33649,y:32673,varname:node_4966,prsc:2|A-9215-OUT,B-7126-OUT,T-3940-OUT;n:type:ShaderForge.SFN_Vector3,id:9215,x:33660,y:32591,varname:node_9215,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Slider,id:3940,x:33525,y:33069,ptovrint:False,ptlb:Normal Power,ptin:_NormalPower,varname:node_3940,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7,max:1;n:type:ShaderForge.SFN_Multiply,id:8781,x:33211,y:33925,varname:node_8781,prsc:2|A-4017-OUT,B-9737-OUT,C-1277-OUT;n:type:ShaderForge.SFN_LightColor,id:2976,x:33013,y:34100,varname:node_2976,prsc:2;n:type:ShaderForge.SFN_LightAttenuation,id:1277,x:33013,y:34229,varname:node_1277,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8579,x:32585,y:33630,varname:node_8579,prsc:2|A-2056-OUT,B-1839-OUT;n:type:ShaderForge.SFN_Vector1,id:1839,x:32287,y:33817,varname:node_1839,prsc:2,v1:0.12;n:type:ShaderForge.SFN_RemapRange,id:5487,x:32599,y:33812,varname:node_5487,prsc:2,frmn:0,frmx:1,tomn:-0.3,tomx:1|IN-8579-OUT;n:type:ShaderForge.SFN_ComponentMask,id:6908,x:33976,y:33265,varname:node_6908,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-4966-OUT;n:type:ShaderForge.SFN_Multiply,id:2364,x:34274,y:33278,varname:node_2364,prsc:2|A-6908-OUT,B-567-OUT,C-5937-OUT;n:type:ShaderForge.SFN_DepthBlend,id:5937,x:34383,y:33423,varname:node_5937,prsc:2|DIST-7249-OUT;n:type:ShaderForge.SFN_Vector1,id:7249,x:34321,y:33593,varname:node_7249,prsc:2,v1:3;n:type:ShaderForge.SFN_Tex2d,id:3961,x:32385,y:32640,varname:node_3961,prsc:2,tex:c781c1bb94fb0e944a34efb2d15461bf,ntxv:0,isnm:False|UVIN-1411-UVOUT,TEX-9128-TEX;n:type:ShaderForge.SFN_Tex2d,id:7678,x:32385,y:32778,varname:node_7678,prsc:2,tex:c781c1bb94fb0e944a34efb2d15461bf,ntxv:0,isnm:False|UVIN-8235-UVOUT,TEX-9128-TEX;n:type:ShaderForge.SFN_Multiply,id:1793,x:32457,y:32009,varname:node_1793,prsc:2|A-4042-OUT,B-7664-OUT;n:type:ShaderForge.SFN_Multiply,id:5236,x:32457,y:32190,varname:node_5236,prsc:2|A-5755-OUT,B-7664-OUT;n:type:ShaderForge.SFN_Vector1,id:7664,x:32208,y:32339,varname:node_7664,prsc:2,v1:15;n:type:ShaderForge.SFN_Lerp,id:9078,x:32751,y:32716,varname:node_9078,prsc:2|A-3961-RGB,B-7678-RGB,T-4724-OUT;n:type:ShaderForge.SFN_ComponentMask,id:369,x:32977,y:32602,varname:node_369,prsc:2,cc1:0,cc2:2,cc3:-1,cc4:-1|IN-9078-OUT;n:type:ShaderForge.SFN_Multiply,id:5724,x:33034,y:32838,varname:node_5724,prsc:2|A-369-OUT,B-5039-OUT;n:type:ShaderForge.SFN_Slider,id:5039,x:32877,y:33011,ptovrint:False,ptlb:Nrm. Detail Power,ptin:_NrmDetailPower,varname:node_5039,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.3,max:1;n:type:ShaderForge.SFN_Add,id:451,x:33256,y:32474,varname:node_451,prsc:2|A-6897-OUT,B-7240-OUT,C-2738-OUT;n:type:ShaderForge.SFN_RemapRange,id:7240,x:33337,y:32636,varname:node_7240,prsc:2,frmn:0,frmx:1,tomn:-0.3,tomx:1|IN-5724-OUT;n:type:ShaderForge.SFN_RemapRange,id:8791,x:33245,y:32937,varname:node_8791,prsc:2,frmn:0,frmx:1,tomn:1,tomx:0|IN-5039-OUT;n:type:ShaderForge.SFN_Multiply,id:2738,x:33465,y:32901,varname:node_2738,prsc:2|A-8791-OUT,B-7510-OUT;n:type:ShaderForge.SFN_Vector1,id:7510,x:33306,y:32846,varname:node_7510,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Add,id:3826,x:33115,y:33332,varname:node_3826,prsc:2|A-2593-OUT,B-8376-OUT;n:type:ShaderForge.SFN_Panner,id:1411,x:32697,y:32042,varname:node_1411,prsc:2,spu:1,spv:1|UVIN-1793-OUT,DIST-564-OUT;n:type:ShaderForge.SFN_Panner,id:8235,x:32697,y:32180,varname:node_8235,prsc:2,spu:-1,spv:-1|UVIN-5236-OUT,DIST-564-OUT;n:type:ShaderForge.SFN_Multiply,id:564,x:32256,y:32078,varname:node_564,prsc:2|A-5521-OUT,B-2026-OUT;n:type:ShaderForge.SFN_Add,id:2026,x:32124,y:32172,varname:node_2026,prsc:2|A-7664-OUT,B-8589-OUT;n:type:ShaderForge.SFN_Vector1,id:8589,x:31904,y:32327,varname:node_8589,prsc:2,v1:1;n:type:ShaderForge.SFN_Desaturate,id:9737,x:33258,y:34097,varname:node_9737,prsc:2|COL-2976-RGB,DES-9386-OUT;n:type:ShaderForge.SFN_Vector1,id:9386,x:33215,y:34289,varname:node_9386,prsc:2,v1:0.3;n:type:ShaderForge.SFN_DepthBlend,id:1940,x:34220,y:32909,varname:node_1940,prsc:2|DIST-5896-OUT;n:type:ShaderForge.SFN_Vector1,id:5896,x:34220,y:33142,varname:node_5896,prsc:2,v1:0.15;n:type:ShaderForge.SFN_Vector1,id:590,x:32829,y:33630,varname:node_590,prsc:2,v1:1.5;n:type:ShaderForge.SFN_RemapRange,id:4033,x:33259,y:33732,varname:node_4033,prsc:2,frmn:0,frmx:15,tomn:0,tomx:1|IN-2629-OUT;n:type:ShaderForge.SFN_Vector1,id:9819,x:31024,y:33901,varname:node_9819,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Vector1,id:567,x:34069,y:33421,varname:node_567,prsc:2,v1:0.17;n:type:ShaderForge.SFN_Vector1,id:5715,x:33799,y:31657,varname:node_5715,prsc:2,v1:5;n:type:ShaderForge.SFN_Vector1,id:3712,x:33897,y:31450,varname:node_3712,prsc:2,v1:0.99;n:type:ShaderForge.SFN_Vector1,id:4092,x:31930,y:33836,varname:node_4092,prsc:2,v1:2;n:type:ShaderForge.SFN_Vector4Property,id:9821,x:32089,y:31157,ptovrint:False,ptlb:Water Parameters,ptin:_WaterParameters,varname:node_9821,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1,v2:1,v3:8,v4:-0.23;n:type:ShaderForge.SFN_Relay,id:2629,x:32790,y:33532,varname:node_2629,prsc:2|IN-9821-Z;n:type:ShaderForge.SFN_Relay,id:8376,x:32978,y:33332,varname:node_8376,prsc:2|IN-9821-W;n:type:ShaderForge.SFN_Tex2dAsset,id:874,x:34953,y:32183,ptovrint:False,ptlb:Foam Map,ptin:_FoamMap,varname:node_874,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:True,tagnrm:False,tex:c4d4fc18cc9f73c49a59628b59c947af,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:6337,x:35212,y:32081,varname:node_6337,prsc:2,tex:c4d4fc18cc9f73c49a59628b59c947af,ntxv:0,isnm:False|UVIN-2010-UVOUT,TEX-874-TEX;n:type:ShaderForge.SFN_Tex2d,id:1747,x:35212,y:32203,varname:node_1747,prsc:2,tex:c4d4fc18cc9f73c49a59628b59c947af,ntxv:0,isnm:False|UVIN-8748-UVOUT,TEX-874-TEX;n:type:ShaderForge.SFN_Multiply,id:1731,x:35438,y:32150,varname:node_1731,prsc:2|A-6337-RGB,B-1747-RGB;n:type:ShaderForge.SFN_DepthBlend,id:3678,x:35490,y:32534,varname:node_3678,prsc:2|DIST-8853-X;n:type:ShaderForge.SFN_Vector4Property,id:8853,x:35257,y:32524,ptovrint:False,ptlb:Foam Parameters,ptin:_FoamParameters,varname:node_8853,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1.5,v2:0.3,v3:1,v4:1;n:type:ShaderForge.SFN_Multiply,id:7952,x:35672,y:32150,varname:node_7952,prsc:2|A-1731-OUT,B-7471-OUT,C-8853-Y;n:type:ShaderForge.SFN_OneMinus,id:7471,x:35672,y:32534,varname:node_7471,prsc:2|IN-3678-OUT;n:type:ShaderForge.SFN_Multiply,id:6576,x:35896,y:32150,varname:node_6576,prsc:2|A-7952-OUT,B-2841-RGB,C-7112-OUT;n:type:ShaderForge.SFN_LightColor,id:2841,x:35672,y:32280,varname:node_2841,prsc:2;n:type:ShaderForge.SFN_LightAttenuation,id:7112,x:35672,y:32407,varname:node_7112,prsc:2;n:type:ShaderForge.SFN_Blend,id:857,x:33688,y:33676,varname:node_857,prsc:2,blmd:6,clmp:True|SRC-6576-OUT,DST-8781-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:2947,x:34927,y:31484,varname:node_2947,prsc:2;n:type:ShaderForge.SFN_ComponentMask,id:6125,x:35094,y:31484,varname:node_6125,prsc:2,cc1:0,cc2:2,cc3:-1,cc4:-1|IN-2947-XYZ;n:type:ShaderForge.SFN_Multiply,id:1853,x:35094,y:31635,varname:node_1853,prsc:2|A-6125-OUT,B-9371-OUT,C-8853-Z;n:type:ShaderForge.SFN_Vector1,id:9371,x:34927,y:31624,varname:node_9371,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:683,x:35270,y:31635,varname:node_683,prsc:2|A-1853-OUT,B-3952-OUT;n:type:ShaderForge.SFN_Vector1,id:3952,x:35094,y:31763,varname:node_3952,prsc:2,v1:0.8;n:type:ShaderForge.SFN_Panner,id:2010,x:35563,y:31480,varname:node_2010,prsc:2,spu:1,spv:1|UVIN-1853-OUT,DIST-8559-OUT;n:type:ShaderForge.SFN_Panner,id:8748,x:35563,y:31630,varname:node_8748,prsc:2,spu:-1,spv:-1|UVIN-6399-OUT,DIST-8559-OUT;n:type:ShaderForge.SFN_Add,id:6399,x:35270,y:31774,varname:node_6399,prsc:2|A-683-OUT,B-77-OUT;n:type:ShaderForge.SFN_Vector2,id:77,x:35094,y:31826,varname:node_77,prsc:2,v1:0.333,v2:0.666;n:type:ShaderForge.SFN_Time,id:5587,x:35472,y:31863,varname:node_5587,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8559,x:35647,y:31863,varname:node_8559,prsc:2|A-5587-TSL,B-8853-W,C-57-OUT;n:type:ShaderForge.SFN_Vector1,id:57,x:35472,y:32010,varname:node_57,prsc:2,v1:3;n:type:ShaderForge.SFN_Code,id:2542,x:33577,y:30782,varname:node_2542,prsc:2,code:ZgBsAG8AYQB0ADQAIAB2AGEAbAAgAD0AIABVAE4ASQBUAFkAXwBTAEEATQBQAEwARQBfAFQARQBYAEMAVQBCAEUAXwBMAE8ARAAoAHUAbgBpAHQAeQBfAFMAcABlAGMAQwB1AGIAZQAwACwAIAByAGUAZgBsAFYAZQBjAHQALAAgAEcAbABvAHMAcwAqADcAKQA7AA0ACgBmAGwAbwBhAHQAMwAgAHIAZQBmAGwAQwBvAGwAIAA9ACAARABlAGMAbwBkAGUASABEAFIAKAB2AGEAbAAsACAAdQBuAGkAdAB5AF8AUwBwAGUAYwBDAHUAYgBlADAAXwBIAEQAUgApADsADQAKAHIAZQB0AHUAcgBuACAAcgBlAGYAbABDAG8AbAA7AA==,output:2,fname:Function_node_2542,width:740,height:177,input:0,input:2,input_1_label:Gloss,input_2_label:reflVect|A-3134-OUT,B-2705-OUT;n:type:ShaderForge.SFN_NormalVector,id:1562,x:33009,y:30915,prsc:2,pt:True;n:type:ShaderForge.SFN_ViewVector,id:7943,x:33009,y:30767,varname:node_7943,prsc:2;n:type:ShaderForge.SFN_Reflect,id:4172,x:33177,y:30767,varname:node_4172,prsc:2|A-7943-OUT,B-1562-OUT;n:type:ShaderForge.SFN_Multiply,id:2705,x:33177,y:30915,varname:node_2705,prsc:2|A-4172-OUT,B-1769-OUT;n:type:ShaderForge.SFN_Vector1,id:1769,x:33009,y:31064,varname:node_1769,prsc:2,v1:-1;n:type:ShaderForge.SFN_RemapRange,id:3134,x:33177,y:31049,varname:node_3134,prsc:2,frmn:0,frmx:1,tomn:1,tomx:0|IN-4690-OUT;n:type:ShaderForge.SFN_If,id:6522,x:34532,y:31129,varname:node_6522,prsc:2|A-9582-OUT,B-2667-OUT,GT-5214-RGB,EQ-2542-OUT,LT-2542-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:9582,x:34494,y:30907,ptovrint:False,ptlb:Enable Planar Reflections,ptin:_EnablePlanarReflections,varname:node_9582,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True;n:type:ShaderForge.SFN_Vector1,id:2667,x:34532,y:31067,varname:node_2667,prsc:2,v1:0;n:type:ShaderForge.SFN_RemapRange,id:5984,x:31029,y:34087,varname:node_5984,prsc:2,frmn:0,frmx:1,tomn:0.1,tomx:1|IN-4690-OUT;n:type:ShaderForge.SFN_OneMinus,id:546,x:33353,y:31270,varname:node_546,prsc:2|IN-5419-V;n:type:ShaderForge.SFN_Append,id:5690,x:33568,y:31281,varname:node_5690,prsc:2|A-5419-U,B-546-OUT;n:type:ShaderForge.SFN_If,id:3958,x:33784,y:31107,varname:node_3958,prsc:2|A-7786-OUT,B-8850-OUT,GT-5690-OUT,EQ-5419-UVOUT,LT-5419-UVOUT;n:type:ShaderForge.SFN_ToggleProperty,id:7786,x:33592,y:31036,ptovrint:False,ptlb:Invert Reflection,ptin:_InvertReflection,varname:node_7786,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_Vector1,id:8850,x:33747,y:31039,varname:node_8850,prsc:2,v1:0;n:type:ShaderForge.SFN_Slider,id:4724,x:31966,y:32775,ptovrint:False,ptlb:Water Direction,ptin:_WaterDirection,varname:node_4724,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.3,cur:0.47,max:0.7;proporder:9128-9821-4724-3940-5039-4690-9582-7786-3221-6001-874-8853-7795;pass:END;sub:END;*/

Shader "DCG/Water Shaders/Water Surface" {
    Properties {
        [NoScaleOffset]_WaterMap ("Water Map", 2D) = "white" {}
        _WaterParameters ("Water Parameters", Vector) = (1,1,8,-0.23)
        _WaterDirection ("Water Direction", Range(0.3, 0.7)) = 0.47
        _NormalPower ("Normal Power", Range(0, 1)) = 0.7
        _NrmDetailPower ("Nrm. Detail Power", Range(0, 1)) = 0.3
        _Gloss ("Gloss", Range(0, 1)) = 0.8
        [MaterialToggle] _EnablePlanarReflections ("Enable Planar Reflections", Float ) = 1
        [MaterialToggle] _InvertReflection ("Invert Reflection", Float ) = 0
        _WaterColor ("Water Color", Color) = (0.7867647,0.9647059,1,1)
        _WaterDensity ("Water Density", Range(0, 1)) = 0.2
        [NoScaleOffset]_FoamMap ("Foam Map", 2D) = "white" {}
        _FoamParameters ("Foam Parameters", Vector) = (1.5,0.3,1,1)
        [HideInInspector]_ReflectionTex ("ReflectionTex", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="AlphaTest+150"
            "RenderType"="Transparent"
        }
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 2.0
            uniform sampler2D _GrabTexture;
            uniform sampler2D _CameraDepthTexture;
            uniform float4 _TimeEditor;
            uniform sampler2D _WaterMap;
            uniform float _Gloss;
            uniform float _WaterDensity;
            uniform float4 _WaterColor;
            uniform sampler2D _ReflectionTex; uniform float4 _ReflectionTex_ST;
            uniform float _NormalPower;
            uniform float _NrmDetailPower;
            uniform float4 _WaterParameters;
            uniform sampler2D _FoamMap;
            uniform float4 _FoamParameters;
            float3 Function_node_2542( float Gloss , float3 reflVect ){
            float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, Gloss*7);
            float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
            return reflCol;
            }
            
            uniform fixed _EnablePlanarReflections;
            uniform fixed _InvertReflection;
            uniform float _WaterDirection;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float3 tangentDir : TEXCOORD2;
                float3 bitangentDir : TEXCOORD3;
                float4 screenPos : TEXCOORD4;
                float4 projPos : TEXCOORD5;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 node_4898 = _Time + _TimeEditor;
                float node_5521 = (node_4898.r*_WaterParameters.g*0.3);
                float2 node_9191 = mul(unity_ObjectToWorld, v.vertex).rgb.rb;
                float2 node_4042 = (float2(node_9191.r,(1.0 - node_9191.g))*_WaterParameters.r*0.0015);
                float2 node_9462 = (node_4042+node_5521*float2(1,1));
                float4 node_5942 = tex2Dlod(_WaterMap,float4(node_9462,0.0,0));
                float2 node_5755 = ((node_4042*0.8)+float2(0.333,0.666));
                float2 node_8281 = (node_5755+node_5521*float2(-1,-1));
                float4 node_9402 = tex2Dlod(_WaterMap,float4(node_8281,0.0,0));
                float3 node_6062 = lerp(node_5942.rgb,node_9402.rgb,_WaterDirection).rbg;
                float node_2593 = node_6062.b;
                float node_2629 = _WaterParameters.b;
                v.vertex.xyz += ((node_2593+_WaterParameters.a)*node_2629*v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                o.screenPos = o.pos;
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                #if UNITY_UV_STARTS_AT_TOP
                    float grabSign = -_ProjectionParams.x;
                #else
                    float grabSign = _ProjectionParams.x;
                #endif
                i.normalDir = normalize(i.normalDir);
                i.screenPos = float4( i.screenPos.xy / i.screenPos.w, 0, 0 );
                i.screenPos.y *= _ProjectionParams.x;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_4898 = _Time + _TimeEditor;
                float node_5521 = (node_4898.r*_WaterParameters.g*0.3);
                float2 node_9191 = i.posWorld.rgb.rb;
                float2 node_4042 = (float2(node_9191.r,(1.0 - node_9191.g))*_WaterParameters.r*0.0015);
                float2 node_9462 = (node_4042+node_5521*float2(1,1));
                float4 node_5942 = tex2D(_WaterMap,node_9462);
                float2 node_5755 = ((node_4042*0.8)+float2(0.333,0.666));
                float2 node_8281 = (node_5755+node_5521*float2(-1,-1));
                float4 node_9402 = tex2D(_WaterMap,node_8281);
                float3 node_6062 = lerp(node_5942.rgb,node_9402.rgb,_WaterDirection).rbg;
                float node_7664 = 15.0;
                float node_564 = (node_5521*(node_7664+1.0));
                float2 node_1411 = ((node_4042*node_7664)+node_564*float2(1,1));
                float4 node_3961 = tex2D(_WaterMap,node_1411);
                float2 node_8235 = ((node_5755*node_7664)+node_564*float2(-1,-1));
                float4 node_7678 = tex2D(_WaterMap,node_8235);
                float3 node_4966 = lerp(float3(0,0,1),float3(((float2(node_6062.r,node_6062.g)*1.3+-0.3)+((lerp(node_3961.rgb,node_7678.rgb,_WaterDirection).rb*_NrmDetailPower)*1.3+-0.3)+((_NrmDetailPower*-1.0+1.0)*0.3)),1.0),_NormalPower);
                float3 normalLocal = node_4966;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = float2(1,grabSign)*i.screenPos.xy*0.5+0.5 + (node_4966.rg*0.17*saturate((sceneZ-partZ)/3.0));
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
////// Emissive:
                float node_6522_if_leA = step(_EnablePlanarReflections,0.0);
                float node_6522_if_leB = step(0.0,_EnablePlanarReflections);
                float3 node_2542 = Function_node_2542( (_Gloss*-1.0+1.0) , (reflect(viewDirection,normalDirection)*(-1.0)) );
                float node_3958_if_leA = step(_InvertReflection,0.0);
                float node_3958_if_leB = step(0.0,_InvertReflection);
                float2 node_3958 = lerp((node_3958_if_leA*sceneUVs.rg)+(node_3958_if_leB*float2(sceneUVs.r,(1.0 - sceneUVs.g))),sceneUVs.rg,node_3958_if_leA*node_3958_if_leB);
                float4 node_5214 = tex2D(_ReflectionTex,TRANSFORM_TEX(node_3958, _ReflectionTex));
                float3 emissive = (lerp((node_6522_if_leA*node_2542)+(node_6522_if_leB*node_5214.rgb),node_2542,node_6522_if_leA*node_6522_if_leB)*0.99*pow(1.0-max(0,dot(normalDirection, viewDirection)),5.0));
                float4 node_5587 = _Time + _TimeEditor;
                float node_8559 = (node_5587.r*_FoamParameters.a*3.0);
                float2 node_1853 = (i.posWorld.rgb.rb*0.1*_FoamParameters.b);
                float2 node_2010 = (node_1853+node_8559*float2(1,1));
                float4 node_6337 = tex2D(_FoamMap,node_2010);
                float2 node_8748 = (((node_1853*0.8)+float2(0.333,0.666))+node_8559*float2(-1,-1));
                float4 node_1747 = tex2D(_FoamMap,node_8748);
                float node_5700 = (-0.1);
                float3 node_1324 = (_WaterColor.rgb*8.0);
                float node_9205 = 1.0;
                float node_9896 = max(0,dot(lightDirection,viewReflectDirection));
                float node_8002 = exp2((_Gloss*10.0+1.0));
                float node_9819 = 0.3;
                float3 node_5487 = ((node_1324*0.12)*1.3+-0.3);
                float node_2593 = node_6062.b;
                float node_2629 = _WaterParameters.b;
                float3 finalColor = emissive + saturate((1.0-(1.0-(((node_6337.rgb*node_1747.rgb)*(1.0 - saturate((sceneZ-partZ)/_FoamParameters.r))*_FoamParameters.g)*_LightColor0.rgb*attenuation))*(1.0-(((pow(saturate((node_9205 + ( (((sceneZ-partZ)*_WaterDensity) - node_5700) * (0.0 - node_9205) ) / (node_1324 - node_5700))),4.0)*sceneColor.rgb)+((pow(node_9896,node_8002)+(pow(node_9896,(node_8002*0.025))*0.07*node_9819)+(pow(node_9896,(node_8002*0.1))*0.13*node_9819))*2.0*(_Gloss*0.9+0.1))+(node_5487*0.02*saturate((sceneZ-partZ)/9.0))+(node_5487*1.5*(saturate(((1.0 - max(0,dot(lightDirection,halfDirection)))*1.6+-0.6))*saturate((node_2593*1.4+-0.1))*saturate(((1.0 - max(0,dot(lightDirection,normalDirection)))*2.0+-1.0)))*(node_2629*0.06666667+0.0)))*lerp(_LightColor0.rgb,dot(_LightColor0.rgb,float3(0.3,0.59,0.11)),0.3)*attenuation))));
                return fixed4(lerp(sceneColor.rgb, finalColor,saturate((sceneZ-partZ)/0.15)),1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 2.0
            uniform sampler2D _GrabTexture;
            uniform sampler2D _CameraDepthTexture;
            uniform float4 _TimeEditor;
            uniform sampler2D _WaterMap;
            uniform float _Gloss;
            uniform float _WaterDensity;
            uniform float4 _WaterColor;
            uniform sampler2D _ReflectionTex; uniform float4 _ReflectionTex_ST;
            uniform float _NormalPower;
            uniform float _NrmDetailPower;
            uniform float4 _WaterParameters;
            uniform sampler2D _FoamMap;
            uniform float4 _FoamParameters;
            float3 Function_node_2542( float Gloss , float3 reflVect ){
            float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, Gloss*7);
            float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
            return reflCol;
            }
            
            uniform fixed _EnablePlanarReflections;
            uniform fixed _InvertReflection;
            uniform float _WaterDirection;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float3 tangentDir : TEXCOORD2;
                float3 bitangentDir : TEXCOORD3;
                float4 screenPos : TEXCOORD4;
                float4 projPos : TEXCOORD5;
                LIGHTING_COORDS(6,7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 node_4898 = _Time + _TimeEditor;
                float node_5521 = (node_4898.r*_WaterParameters.g*0.3);
                float2 node_9191 = mul(unity_ObjectToWorld, v.vertex).rgb.rb;
                float2 node_4042 = (float2(node_9191.r,(1.0 - node_9191.g))*_WaterParameters.r*0.0015);
                float2 node_9462 = (node_4042+node_5521*float2(1,1));
                float4 node_5942 = tex2Dlod(_WaterMap,float4(node_9462,0.0,0));
                float2 node_5755 = ((node_4042*0.8)+float2(0.333,0.666));
                float2 node_8281 = (node_5755+node_5521*float2(-1,-1));
                float4 node_9402 = tex2Dlod(_WaterMap,float4(node_8281,0.0,0));
                float3 node_6062 = lerp(node_5942.rgb,node_9402.rgb,_WaterDirection).rbg;
                float node_2593 = node_6062.b;
                float node_2629 = _WaterParameters.b;
                v.vertex.xyz += ((node_2593+_WaterParameters.a)*node_2629*v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                o.screenPos = o.pos;
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                #if UNITY_UV_STARTS_AT_TOP
                    float grabSign = -_ProjectionParams.x;
                #else
                    float grabSign = _ProjectionParams.x;
                #endif
                i.normalDir = normalize(i.normalDir);
                i.screenPos = float4( i.screenPos.xy / i.screenPos.w, 0, 0 );
                i.screenPos.y *= _ProjectionParams.x;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_4898 = _Time + _TimeEditor;
                float node_5521 = (node_4898.r*_WaterParameters.g*0.3);
                float2 node_9191 = i.posWorld.rgb.rb;
                float2 node_4042 = (float2(node_9191.r,(1.0 - node_9191.g))*_WaterParameters.r*0.0015);
                float2 node_9462 = (node_4042+node_5521*float2(1,1));
                float4 node_5942 = tex2D(_WaterMap,node_9462);
                float2 node_5755 = ((node_4042*0.8)+float2(0.333,0.666));
                float2 node_8281 = (node_5755+node_5521*float2(-1,-1));
                float4 node_9402 = tex2D(_WaterMap,node_8281);
                float3 node_6062 = lerp(node_5942.rgb,node_9402.rgb,_WaterDirection).rbg;
                float node_7664 = 15.0;
                float node_564 = (node_5521*(node_7664+1.0));
                float2 node_1411 = ((node_4042*node_7664)+node_564*float2(1,1));
                float4 node_3961 = tex2D(_WaterMap,node_1411);
                float2 node_8235 = ((node_5755*node_7664)+node_564*float2(-1,-1));
                float4 node_7678 = tex2D(_WaterMap,node_8235);
                float3 node_4966 = lerp(float3(0,0,1),float3(((float2(node_6062.r,node_6062.g)*1.3+-0.3)+((lerp(node_3961.rgb,node_7678.rgb,_WaterDirection).rb*_NrmDetailPower)*1.3+-0.3)+((_NrmDetailPower*-1.0+1.0)*0.3)),1.0),_NormalPower);
                float3 normalLocal = node_4966;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = float2(1,grabSign)*i.screenPos.xy*0.5+0.5 + (node_4966.rg*0.17*saturate((sceneZ-partZ)/3.0));
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float4 node_5587 = _Time + _TimeEditor;
                float node_8559 = (node_5587.r*_FoamParameters.a*3.0);
                float2 node_1853 = (i.posWorld.rgb.rb*0.1*_FoamParameters.b);
                float2 node_2010 = (node_1853+node_8559*float2(1,1));
                float4 node_6337 = tex2D(_FoamMap,node_2010);
                float2 node_8748 = (((node_1853*0.8)+float2(0.333,0.666))+node_8559*float2(-1,-1));
                float4 node_1747 = tex2D(_FoamMap,node_8748);
                float node_5700 = (-0.1);
                float3 node_1324 = (_WaterColor.rgb*8.0);
                float node_9205 = 1.0;
                float node_9896 = max(0,dot(lightDirection,viewReflectDirection));
                float node_8002 = exp2((_Gloss*10.0+1.0));
                float node_9819 = 0.3;
                float3 node_5487 = ((node_1324*0.12)*1.3+-0.3);
                float node_2593 = node_6062.b;
                float node_2629 = _WaterParameters.b;
                float3 finalColor = saturate((1.0-(1.0-(((node_6337.rgb*node_1747.rgb)*(1.0 - saturate((sceneZ-partZ)/_FoamParameters.r))*_FoamParameters.g)*_LightColor0.rgb*attenuation))*(1.0-(((pow(saturate((node_9205 + ( (((sceneZ-partZ)*_WaterDensity) - node_5700) * (0.0 - node_9205) ) / (node_1324 - node_5700))),4.0)*sceneColor.rgb)+((pow(node_9896,node_8002)+(pow(node_9896,(node_8002*0.025))*0.07*node_9819)+(pow(node_9896,(node_8002*0.1))*0.13*node_9819))*2.0*(_Gloss*0.9+0.1))+(node_5487*0.02*saturate((sceneZ-partZ)/9.0))+(node_5487*1.5*(saturate(((1.0 - max(0,dot(lightDirection,halfDirection)))*1.6+-0.6))*saturate((node_2593*1.4+-0.1))*saturate(((1.0 - max(0,dot(lightDirection,normalDirection)))*2.0+-1.0)))*(node_2629*0.06666667+0.0)))*lerp(_LightColor0.rgb,dot(_LightColor0.rgb,float3(0.3,0.59,0.11)),0.3)*attenuation))));
                return fixed4(finalColor * saturate((sceneZ-partZ)/0.15),0);
            }
            ENDCG
        }
    }
    //CustomEditor "ShaderForgeMaterialInspector"
}
