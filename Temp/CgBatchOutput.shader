Shader "Custom/RotateUVs" {

    Properties {

        _MainTex ("Color (RGB) Alpha (A)", 2D) = "white" {}

        _RotationSpeed ("Rotation Speed", Float) = 500.0

    }

    SubShader {

        Tags { "Queue"="Transparent" "RenderType"="Transparent" }

        LOD 200

        

        	Alphatest Greater 0 ZWrite Off ColorMask RGB
	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
		Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
// Vertex combos: 4
//   opengl - ALU: 50 to 99
//   d3d9 - ALU: 30 to 82
//   d3d11 - ALU: 13 to 51, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 13 to 51, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_Time]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 5 [_Object2World]
Vector 17 [unity_Scale]
Float 18 [_RotationSpeed]
Vector 19 [_MainTex_ST]
"!!ARBvp1.0
# 71 ALU
PARAM c[24] = { { 0.5, 24.980801, -24.980801, 0.15915491 },
		state.matrix.mvp,
		program.local[5..19],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75, 0.25, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[9];
MUL R0.x, R0, c[18];
MUL R0.x, R0, c[0].w;
FRC R1.w, R0.x;
ADD R0.y, R0.x, -c[23].z;
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[20];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].yzyw;
ADD R0.xyz, -R1.w, c[20];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].yzyw;
ADD R1.xyz, R1, c[21].xyxw;
MAD R1.xyz, R1, R0, c[21].zwzw;
MAD R1.xyz, R1, R0, c[22].xyxw;
MAD R1.xyz, R1, R0, c[22].zwzw;
ADD R3.xyz, R3, c[21].xyxw;
MAD R3.xyz, R3, R2, c[21].zwzw;
MAD R3.xyz, R3, R2, c[22].xyxw;
MAD R3.xyz, R3, R2, c[22].zwzw;
MAD R1.xyz, R1, R0, c[20].wzww;
SLT R4.x, R1.w, c[23].z;
SGE R4.yz, R1.w, c[23].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[20].wzww;
DP3 R4.x, R1, -R0;
MAD R1.xyz, R3, R2, c[20].wzww;
SLT R0.x, R0.w, c[23].z;
SGE R0.yz, R0.w, c[23].xxyw;
DP3 R2.y, R0, c[20].wzww;
MOV R2.xz, R0;
DP3 R0.x, R1, -R2;
MOV R4.y, -R0.x;
MOV R0.y, R4.x;
MAD R0.xy, R0, c[0].x, c[0].x;
MUL R0.zw, R0.xyxy, c[23].w;
MAD R1.xy, R4, c[0].x, c[0].x;
MUL R0.xy, R1, c[23].w;
ADD R1.xy, R0.zwzw, -c[20].z;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R1.xy, R0.w, R1;
ADD R0.xy, R0, -c[20].z;
MAD R0.xy, R0.z, R0, R1;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[7];
ADD R0.xy, R0, c[0].x;
DP3 R3.w, R1, c[6];
MAD result.texcoord[0].xy, R0, c[19], c[19].zwzw;
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[20].z;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R3.w, R3.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
MAD R0.y, R0.x, R0.x, -R0;
MUL R1.xyz, R0.y, c[16];
ADD R2.xyz, R2, R3;
ADD result.texcoord[2].xyz, R2, R1;
MOV result.texcoord[1].z, R2.w;
MOV result.texcoord[1].y, R3.w;
MOV result.texcoord[1].x, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 71 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Matrix 4 [_Object2World]
Vector 16 [unity_Scale]
Float 17 [_RotationSpeed]
Vector 18 [_MainTex_ST]
"vs_2_0
; 52 ALU
def c19, -0.50000000, 0.15915491, 0.50000000, 1.00000000
def c20, 6.28318501, -3.14159298, 2.00000000, -1.00000000
def c21, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c22, -0.02083333, -0.12500000, 1.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
mul r0.xyz, v2, c16.w
dp3 r4.x, r0, c5
dp3 r2.w, r0, c6
dp3 r3.w, r0, c4
mov r0.x, c17
mul r0.x, c8, r0
mad r0.x, r0, c19.y, c19.z
mov r3.x, r4
mov r3.y, r2.w
mov r3.z, c19.w
mul r1, r3.wxyy, r3.xyyw
dp4 r2.y, r3.wxyz, c10
dp4 r2.x, r3.wxyz, c9
dp4 r2.z, r3.wxyz, c11
frc r0.x, r0
mad r3.x, r0, c20, c20.y
sincos r0.xy, r3.x, c21.xyzw, c22.xyzw
dp4 r3.z, r1, c14
dp4 r3.y, r1, c13
dp4 r3.x, r1, c12
add r1.xyz, r2, r3
mov r0.w, -r0.y
mov r0.z, r0.x
mad r0.xy, r0.yxzw, c19.z, c19.z
mad r2.xy, r0, c20.z, c20.w
add r0.xy, v3, c19.x
mad r0.zw, r0, c19.z, c19.z
mad r0.zw, r0, c20.z, c20.w
mul r2.xy, r0.y, r2
mad r2.xy, r0.x, r0.zwzw, r2
mul r1.w, r4.x, r4.x
mad r0.y, r3.w, r3.w, -r1.w
mul r0.xyz, r0.y, c15
add r2.xy, r2, c19.z
add oT2.xyz, r1, r0
mad oT0.xy, r2, c18, c18.zwzw
mov oT1.z, r2.w
mov oT1.y, r4.x
mov oT1.x, r3.w
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_MainTex_ST]
Matrix 12 [_Object2World] 3
Float 16 [_RotationSpeed]
Vector 0 [_Time]
Matrix 8 [glstate_matrix_mvp] 4
Vector 3 [unity_SHAb]
Vector 2 [unity_SHAg]
Vector 1 [unity_SHAr]
Vector 6 [unity_SHBb]
Vector 5 [unity_SHBg]
Vector 4 [unity_SHBr]
Vector 7 [unity_SHC]
Vector 15 [unity_Scale]
// Shader Timing Estimate, in Cycles/64 vertex vector:
// ALU: 33.33 (25 instructions), vertex: 32, texture: 0,
//   sequencer: 16,  5 GPRs, 31 threads,
// Performance (if enough threads): ~33 cycles per vector
// * Vertex cycle estimates are assuming 3 vfetch_minis for every vfetch_full,
//     with <= 32 bytes per vfetch_full group.

"vs_360
backbbabaaaaacjmaaaaabmmaaaaaaaaaaaaaaceaaaaacciaaaaacfaaaaaaaaa
aaaaaaaaaaaaacaaaaaaaabmaaaaabpepppoadaaaaaaaaanaaaaaabmaaaaaaaa
aaaaabonaaaaabcaaaacaabbaaabaaaaaaaaabcmaaaaaaaaaaaaabdmaaacaaam
aaadaaaaaaaaabemaaaaaaaaaaaaabfmaaacaabaaaabaaaaaaaaabgmaaaaaaaa
aaaaabhmaaacaaaaaaabaaaaaaaaabcmaaaaaaaaaaaaabicaaacaaaiaaaeaaaa
aaaaabemaaaaaaaaaaaaabjfaaacaaadaaabaaaaaaaaabcmaaaaaaaaaaaaabka
aaacaaacaaabaaaaaaaaabcmaaaaaaaaaaaaabklaaacaaabaaabaaaaaaaaabcm
aaaaaaaaaaaaablgaaacaaagaaabaaaaaaaaabcmaaaaaaaaaaaaabmbaaacaaaf
aaabaaaaaaaaabcmaaaaaaaaaaaaabmmaaacaaaeaaabaaaaaaaaabcmaaaaaaaa
aaaaabnhaaacaaahaaabaaaaaaaaabcmaaaaaaaaaaaaabobaaacaaapaaabaaaa
aaaaabcmaaaaaaaafpengbgjgofegfhifpfdfeaaaaabaaadaaabaaaeaaabaaaa
aaaaaaaafpepgcgkgfgdhedcfhgphcgmgeaaklklaaadaaadaaaeaaaeaaabaaaa
aaaaaaaafpfcgphegbhegjgpgofdhagfgfgeaaklaaaaaaadaaabaaabaaabaaaa
aaaaaaaafpfegjgngfaaghgmhdhegbhegffpgngbhehcgjhifpgnhghaaahfgogj
hehjfpfdeiebgcaahfgogjhehjfpfdeiebghaahfgogjhehjfpfdeiebhcaahfgo
gjhehjfpfdeiecgcaahfgogjhehjfpfdeiecghaahfgogjhehjfpfdeiechcaahf
gogjhehjfpfdeiedaahfgogjhehjfpfdgdgbgmgfaahghdfpddfpdaaadccodaco
dcdadddfddcodaaaaaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaabeaapmaaba
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaabimaacbaaaeaaaaaaaa
aaaaaaaaaaaacagdaaaaaaabaaaaaaadaaaaaaadaaaaacjaaabaaaaeaaaadaaf
aadafaagaaaadafaaaabhbfbaaachcfcaaaababpaaaababcaaaababmaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaamaejapnl
eamjapnlaaaaaaaaaaaaaaaalpaaaaaadpaaaaaalpiaaaaadoccpjidhabfdaae
aaaabcaamcaaaaaaaaaaeaahaaaabcaameaaaaaaaaaagaalgabbbcaabcaaaaaa
aaaagabhdabnbcaaccaaaaaaafpidaaaaaaaagiiaaaaaaaaafpibaaaaaaaaoii
aaaaaaaaafpiaaaaaaaaaohiaaaaaaaamiapaaacaabliiaakbadalaamiapaaac
aamgiiaakladakacmiapaaacaalbdejekladajacmiapiadoaagmaadekladaiac
miacaaaaaagmblaacbbappaamiahaaabaagfblaakbabapaakichaaacaalbleeb
ibabaoaamiahaaacaagmlemaklabanacmiadaaabaalclaaakaaappaacmiaaaaa
aaaaaalbocaaaaabmiahaaacaamglemaklabamacmiahiaabaaleleaaocacacaa
miaiaaabaabllbgmilaapopoceipacaeaalehcgmobacacialiebaaadabdoania
epabacppaibcaaadaadoangmgpacacacaiceaaadaadoanmggpadacacgeebabac
aakhkhgbkpaeaeaamabcaaacaakhkhblkpaeafabkiieaaacaakhkhmaipaeagpp
mechaaacaalolobloaadacabmiahiaacaamgmagfklabahacmiadaaabaagmlalb
mlabaappmiadaaaaaabkmflaolaaaaabmiadiaaaaalalabkilaabbbbaaaaaaaa
aaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_Time]
Vector 466 [unity_SHAr]
Vector 465 [unity_SHAg]
Vector 464 [unity_SHAb]
Vector 463 [unity_SHBr]
Vector 462 [unity_SHBg]
Vector 461 [unity_SHBb]
Vector 460 [unity_SHC]
Matrix 260 [_Object2World]
Vector 459 [unity_Scale]
Float 458 [_RotationSpeed]
Vector 457 [_MainTex_ST]
"sce_vp_rsx // 36 instructions using 5 registers
[Configuration]
8
0000002401050500
[Defaults]
1
456 3
3f000000400000003f800000
[Microcode]
576
00001c6c009cb20c013fc0c36041dffc00021c6c00dc88800186c08200419ffc
401f9c6c01d0300d8106c0c360403f80401f9c6c01d0200d8106c0c360405f80
401f9c6c01d0100d8106c0c360409f80401f9c6c01d0000d8106c0c360411f80
00001c6c005d30000186c08360403ffc00011c6c0150600c008600c360409ffc
00011c6c0150500c008600c360405ffc00009c6c0150400c008600c360411ffc
00011c6c009ca07f808000c360411ffc401f9c6c004000000286c08360411fa0
00001c6c0080005504aa824360403ffc40009c6c004000550486c08360409fa0
40009c6c0040002a8486c08360405fa000001c6c019d000c0286c0c360405ffc
00001c6c819d100c0286c0c0012481fc00001c6c019d200c0286c0c360411ffc
00001c6c010000000280017fe0203ffc00009c6c7880000d029a01400131e1fc
00019c6c004000550686c08360409ffc00019c6c004000800686c08360403ffc
00011c6c01dcd00d8286c0c360405ffc00011c6c01dce00d8286c0c360409ffc
00011c6c01dcf00d8286c0c360411ffc00009c6c011c805d068000c000619ffc
00009c6c011c8000868000c000607ffc00011c6c00c0000c0086c0830121dffc
00001c6c009cc07f808600c36041dffc00009c6c011c8055829540f540607ffc
00009c6c011c8008029540f540619ffc00009c6c0080002a88aac14360407ffc
00009c6c010000000884015740a19ffc00009c6c00dc80000186c08200a19ffc
401f9c6c00c0000c0086c0830121dfa4401f9c6c011c9008028400d740619f9d
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 80 // 80 used size, 5 vars
Float 48 [_RotationSpeed]
Vector 64 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 32 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedggchdkdipiilkgkfifeeplppllmpfnikabaaaaaageagaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oaaeaaaaeaaaabaadiabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaaakiacaaa
abaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaa
aaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaa
adaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaa
acaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaa
bgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = _glesMultiTexCoord0.zw;
  tmpvar_4.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_5;
  tmpvar_5 = sin((_RotationSpeed * _Time));
  highp float tmpvar_6;
  tmpvar_6 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_7;
  tmpvar_7[0].x = tmpvar_6;
  tmpvar_7[0].y = tmpvar_5.x;
  tmpvar_7[1].x = -(tmpvar_5.x);
  tmpvar_7[1].y = tmpvar_6;
  tmpvar_4.xy = (tmpvar_4.xy * ((((tmpvar_7 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_4.xy = (tmpvar_4.xy + 0.5);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  shlight_1 = tmpvar_11;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_4.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = c_4.xyz;
  tmpvar_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = c_4.w;
  tmpvar_3 = tmpvar_7;
  lowp vec4 c_8;
  c_8.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_8.w = tmpvar_3;
  c_1.xyz = (c_8.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = _glesMultiTexCoord0.zw;
  tmpvar_4.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_5;
  tmpvar_5 = sin((_RotationSpeed * _Time));
  highp float tmpvar_6;
  tmpvar_6 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_7;
  tmpvar_7[0].x = tmpvar_6;
  tmpvar_7[0].y = tmpvar_5.x;
  tmpvar_7[1].x = -(tmpvar_5.x);
  tmpvar_7[1].y = tmpvar_6;
  tmpvar_4.xy = (tmpvar_4.xy * ((((tmpvar_7 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_4.xy = (tmpvar_4.xy + 0.5);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  shlight_1 = tmpvar_11;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_4.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = c_4.xyz;
  tmpvar_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = c_4.w;
  tmpvar_3 = tmpvar_7;
  lowp vec4 c_8;
  c_8.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_8.w = tmpvar_3;
  c_1.xyz = (c_8.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Matrix 4 [_Object2World]
Vector 16 [unity_Scale]
Float 17 [_RotationSpeed]
Vector 18 [_MainTex_ST]
"agal_vs
c19 -0.5 0.159155 0.5 1.0
c20 6.283185 -3.141593 2.0 -1.0
c21 -0.000002 -0.000022 0.002604 0.00026
c22 -0.020833 -0.125 1.0 0.5
[bc]
adaaaaaaaaaaahacabaaaaoeaaaaaaaabaaaaappabaaaaaa mul r0.xyz, a1, c16.w
bcaaaaaaaeaaabacaaaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r4.x, r0.xyzz, c5
bcaaaaaaacaaaiacaaaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r2.w, r0.xyzz, c6
bcaaaaaaadaaaiacaaaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r3.w, r0.xyzz, c4
aaaaaaaaaaaaabacbbaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c17
adaaaaaaaaaaabacaiaaaaoeabaaaaaaaaaaaaaaacaaaaaa mul r0.x, c8, r0.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaabdaaaaffabaaaaaa mul r0.x, r0.x, c19.y
abaaaaaaaaaaabacaaaaaaaaacaaaaaabdaaaakkabaaaaaa add r0.x, r0.x, c19.z
aaaaaaaaadaaabacaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r3.x, r4.x
aaaaaaaaadaaacacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r3.y, r2.w
aaaaaaaaadaaaeacbdaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r3.z, c19.w
adaaaaaaabaaapacadaaaafdacaaaaaaadaaaaneacaaaaaa mul r1, r3.wxyy, r3.xyyw
bdaaaaaaacaaacacadaaaajdacaaaaaaakaaaaoeabaaaaaa dp4 r2.y, r3.wxyz, c10
bdaaaaaaacaaabacadaaaajdacaaaaaaajaaaaoeabaaaaaa dp4 r2.x, r3.wxyz, c9
bdaaaaaaacaaaeacadaaaajdacaaaaaaalaaaaoeabaaaaaa dp4 r2.z, r3.wxyz, c11
aiaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa frc r0.x, r0.x
adaaaaaaadaaabacaaaaaaaaacaaaaaabeaaaaoeabaaaaaa mul r3.x, r0.x, c20
abaaaaaaadaaabacadaaaaaaacaaaaaabeaaaaffabaaaaaa add r3.x, r3.x, c20.y
apaaaaaaaaaaabacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sin r0.x, r3.x
baaaaaaaaaaaacacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa cos r0.y, r3.x
bdaaaaaaadaaaeacabaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r3.z, r1, c14
bdaaaaaaadaaacacabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r3.y, r1, c13
bdaaaaaaadaaabacabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 r3.x, r1, c12
abaaaaaaabaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r1.xyz, r2.xyzz, r3.xyzz
bfaaaaaaaaaaaiacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.w, r0.y
aaaaaaaaaaaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.z, r0.x
adaaaaaaaaaaadacaaaaaaabacaaaaaabdaaaakkabaaaaaa mul r0.xy, r0.yxxx, c19.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabdaaaakkabaaaaaa add r0.xy, r0.xyyy, c19.z
adaaaaaaacaaadacaaaaaafeacaaaaaabeaaaakkabaaaaaa mul r2.xy, r0.xyyy, c20.z
abaaaaaaacaaadacacaaaafeacaaaaaabeaaaappabaaaaaa add r2.xy, r2.xyyy, c20.w
abaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaaaabaaaaaa add r0.xy, a3, c19.x
adaaaaaaaaaaamacaaaaaaopacaaaaaabdaaaakkabaaaaaa mul r0.zw, r0.wwzw, c19.z
abaaaaaaaaaaamacaaaaaaopacaaaaaabdaaaakkabaaaaaa add r0.zw, r0.wwzw, c19.z
adaaaaaaaaaaamacaaaaaaopacaaaaaabeaaaakkabaaaaaa mul r0.zw, r0.wwzw, c20.z
abaaaaaaaaaaamacaaaaaaopacaaaaaabeaaaappabaaaaaa add r0.zw, r0.wwzw, c20.w
adaaaaaaacaaadacaaaaaaffacaaaaaaacaaaafeacaaaaaa mul r2.xy, r0.y, r2.xyyy
adaaaaaaaeaaagacaaaaaaaaacaaaaaaaaaaaapoacaaaaaa mul r4.yz, r0.x, r0.zwww
abaaaaaaacaaadacaeaaaakjacaaaaaaacaaaafeacaaaaaa add r2.xy, r4.yzzz, r2.xyyy
adaaaaaaabaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r1.w, r4.x, r4.x
adaaaaaaafaaacacadaaaappacaaaaaaadaaaappacaaaaaa mul r5.y, r3.w, r3.w
acaaaaaaaaaaacacafaaaaffacaaaaaaabaaaappacaaaaaa sub r0.y, r5.y, r1.w
adaaaaaaaaaaahacaaaaaaffacaaaaaaapaaaaoeabaaaaaa mul r0.xyz, r0.y, c15
abaaaaaaacaaadacacaaaafeacaaaaaabdaaaakkabaaaaaa add r2.xy, r2.xyyy, c19.z
abaaaaaaacaaahaeabaaaakeacaaaaaaaaaaaakeacaaaaaa add v2.xyz, r1.xyzz, r0.xyzz
adaaaaaaafaaadacacaaaafeacaaaaaabcaaaaoeabaaaaaa mul r5.xy, r2.xyyy, c18
abaaaaaaaaaaadaeafaaaafeacaaaaaabcaaaaooabaaaaaa add v0.xy, r5.xyyy, c18.zwzw
aaaaaaaaabaaaeaeacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v1.z, r2.w
aaaaaaaaabaaacaeaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v1.y, r4.x
aaaaaaaaabaaabaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v1.x, r3.w
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 80 // 80 used size, 5 vars
Float 48 [_RotationSpeed]
Vector 64 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 32 instructions, 4 temp regs, 0 temp arrays:
// ALU 27 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedngpjnogpcglelkclnbkmjiolmbnnngpaabaaaaaabiakaaaaaeaaaaaa
daaaaaaaoaadaaaamiaiaaaajaajaaaaebgpgodjkiadaaaakiadaaaaaaacpopp
diadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaacaacgaaahaaaeaaaaaaaaaa
adaaaaaaaeaaalaaaaaaaaaaadaaamaaadaaapaaaaaaaaaaadaabeaaabaabcaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapkaaaaaaalpidpjccdoaaaaaadp
aaaaiadofbaaaaafbeaaapkanlapmjeanlapejmagdibihlekblfmpdhfbaaaaaf
bfaaapkalkajlglkkekkckdnaaaaiadpaaaaaamabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaabaaaaacaaaaabia
abaaaakaafaaaaadaaaaabiaaaaaaaiaadaaaakaaeaaaaaeaaaaapiaaaaaaaia
bdaaffkabdaalokabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeia
beaaaakabeaaffkaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeabaaapia
aaaaoliabeaakkkabeaappkaaeaaaaaeabaaapiaaaaaoliaabaaoeiabfaaaaka
aeaaaaaeabaaapiaaaaaoliaabaaoeiabfaaffkaaeaaaaaeabaaapiaaaaaolia
abaaoeiabdaaaakaaeaaaaaeaaaaapiaaaaaoeiaabaaoeiabfaakkkaaeaaaaae
aaaaapiaaaaaoeiabdaaikkabdaakkkaaeaaaaaeaaaaapiaaaaaoeiabfaappkb
bfaakkkbacaaaaadabaaapiaadaaeejabdaaaakaafaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaadiaaaaaoniaaaaaoiiaacaaaaadaaaaadiaaaaaoeia
bdaakkkaaeaaaaaeaaaaadoaaaaaoeiaacaaoekaacaaookaafaaaaadaaaaahia
acaaoejabcaappkaafaaaaadabaaahiaaaaaffiabaaaoekaaeaaaaaeaaaaalia
apaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiabbaaoekaaaaakkiaaaaapeia
abaaaaacaaaaaiiabfaakkkaajaaaaadabaaabiaaeaaoekaaaaaoeiaajaaaaad
abaaaciaafaaoekaaaaaoeiaajaaaaadabaaaeiaagaaoekaaaaaoeiaafaaaaad
acaaapiaaaaacjiaaaaakeiaajaaaaadadaaabiaahaaoekaacaaoeiaajaaaaad
adaaaciaaiaaoekaacaaoeiaajaaaaadadaaaeiaajaaoekaacaaoeiaacaaaaad
abaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiiaaaaaffiaaaaaffiaaeaaaaae
aaaaaiiaaaaaaaiaaaaaaaiaaaaappibabaaaaacabaaahoaaaaaoeiaaeaaaaae
acaaahoaakaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaamaaoeka
aeaaaaaeaaaaapiaalaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcoaaeaaaaeaaaabaadiabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaa
akiacaaaabaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaap
hcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaa
egbabaaaadaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaacaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaa
acaaaaaabgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    lowp vec3 vlight;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 424
uniform highp vec4 _MainTex_ST;
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 398
void vert( inout appdata_full v ) {
    v.texcoord.xy -= 0.5;
    #line 401
    highp float s = float( sin((_RotationSpeed * _Time)));
    highp float c = float( cos((_RotationSpeed * _Time)));
    highp mat2 rotationMatrix = mat2( c, s, (-s), c);
    rotationMatrix *= 0.5;
    #line 405
    rotationMatrix += 0.5;
    rotationMatrix = ((rotationMatrix * 2.0) - 1.0);
    v.texcoord.xy = (v.texcoord.xy * rotationMatrix);
    v.texcoord.xy += 0.5;
}
#line 425
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 428
    vert( v);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 432
    o.normal = worldN;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 436
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD2 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    lowp vec3 vlight;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 424
uniform highp vec4 _MainTex_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 410
void surf( in Input IN, inout SurfaceOutput o ) {
    mediump vec4 c = texture( _MainTex, IN.uv_MainTex);
    o.Albedo = c.xyz;
    #line 414
    o.Alpha = c.w;
}
#line 438
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 440
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 444
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 448
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    #line 452
    c = LightingLambert( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.w = o.Alpha;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN.vlight = vec3(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_Time]
Float 10 [_RotationSpeed]
Vector 11 [unity_LightmapST]
Vector 12 [_MainTex_ST]
"!!ARBvp1.0
# 50 ALU
PARAM c[17] = { { 0.5, 24.980801, -24.980801, 0.15915491 },
		state.matrix.mvp,
		program.local[5..12],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75, 0.25, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[9];
MUL R0.x, R0, c[10];
MUL R0.x, R0, c[0].w;
FRC R1.w, R0.x;
ADD R0.y, R0.x, -c[16].z;
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[13];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].yzyw;
ADD R0.xyz, -R1.w, c[13];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].yzyw;
ADD R1.xyz, R1, c[14].xyxw;
MAD R1.xyz, R1, R0, c[14].zwzw;
MAD R1.xyz, R1, R0, c[15].xyxw;
MAD R1.xyz, R1, R0, c[15].zwzw;
ADD R3.xyz, R3, c[14].xyxw;
MAD R3.xyz, R3, R2, c[14].zwzw;
MAD R3.xyz, R3, R2, c[15].xyxw;
MAD R1.xyz, R1, R0, c[13].wzww;
MAD R3.xyz, R3, R2, c[15].zwzw;
SLT R4.x, R1.w, c[16].z;
SGE R4.yz, R1.w, c[16].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[13].wzww;
DP3 R4.x, R1, -R0;
MAD R1.xyz, R3, R2, c[13].wzww;
SLT R0.x, R0.w, c[16].z;
SGE R0.yz, R0.w, c[16].xxyw;
DP3 R2.y, R0, c[13].wzww;
MOV R2.xz, R0;
DP3 R0.x, R1, -R2;
MOV R4.y, -R0.x;
MOV R0.y, R4.x;
MAD R0.xy, R0, c[0].x, c[0].x;
MUL R0.zw, R0.xyxy, c[16].w;
MAD R1.xy, R4, c[0].x, c[0].x;
MUL R0.xy, R1, c[16].w;
ADD R1.xy, R0.zwzw, -c[13].z;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R1.xy, R0.w, R1;
ADD R0.xy, R0, -c[13].z;
MAD R0.xy, R0.z, R0, R1;
ADD R0.xy, R0, c[0].x;
MAD result.texcoord[0].xy, R0, c[12], c[12].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[11], c[11].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 50 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Float 9 [_RotationSpeed]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
"vs_2_0
; 30 ALU
def c12, -0.50000000, 0.15915491, 0.50000000, 0
def c13, 6.28318501, -3.14159298, 2.00000000, -1.00000000
def c14, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c15, -0.02083333, -0.12500000, 1.00000000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c9
mul r0.x, c8, r0
mad r0.x, r0, c12.y, c12.z
frc r0.x, r0
mad r1.x, r0, c13, c13.y
sincos r0.xy, r1.x, c14.xyzw, c15.xyzw
mad r0.zw, r0.xyyx, c12.z, c12.z
mad r1.xy, r0.zwzw, c13.z, c13.w
add r0.zw, v3.xyxy, c12.x
mov r0.y, -r0
mad r0.xy, r0, c12.z, c12.z
mul r1.xy, r0.w, r1
mad r0.xy, r0, c13.z, c13.w
mad r0.xy, r0.z, r0, r1
add r0.xy, r0, c12.z
mad oT0.xy, r0, c11, c11.zwzw
mad oT1.xy, v4, c10, c10.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 7 [_MainTex_ST]
Float 5 [_RotationSpeed]
Vector 0 [_Time]
Matrix 1 [glstate_matrix_mvp] 4
Vector 6 [unity_LightmapST]
// Shader Timing Estimate, in Cycles/64 vertex vector:
// ALU: 20.00 (15 instructions), vertex: 32, texture: 0,
//   sequencer: 12,  4 GPRs, 31 threads,
// Performance (if enough threads): ~32 cycles per vector
// * Vertex cycle estimates are assuming 3 vfetch_minis for every vfetch_full,
//     with <= 32 bytes per vfetch_full group.

"vs_360
backbbabaaaaabkaaaaaabeiaaaaaaaaaaaaaaceaaaaabdeaaaaabfmaaaaaaaa
aaaaaaaaaaaaabamaaaaaabmaaaaabaapppoadaaaaaaaaafaaaaaabmaaaaaaaa
aaaaaapjaaaaaaiaaaacaaahaaabaaaaaaaaaaimaaaaaaaaaaaaaajmaaacaaaf
aaabaaaaaaaaaakmaaaaaaaaaaaaaalmaaacaaaaaaabaaaaaaaaaaimaaaaaaaa
aaaaaamcaaacaaabaaaeaaaaaaaaaaniaaaaaaaaaaaaaaoiaaacaaagaaabaaaa
aaaaaaimaaaaaaaafpengbgjgofegfhifpfdfeaaaaabaaadaaabaaaeaaabaaaa
aaaaaaaafpfcgphegbhegjgpgofdhagfgfgeaaklaaaaaaadaaabaaabaaabaaaa
aaaaaaaafpfegjgngfaaghgmhdhegbhegffpgngbhehcgjhifpgnhghaaaklklkl
aaadaaadaaaeaaaeaaabaaaaaaaaaaaahfgogjhehjfpemgjghgihegngbhafdfe
aahghdfpddfpdaaadccodacodcdadddfddcodaaaaaaaaaaaaaaaaaabaaaaaaaa
aaaaaaaaaaaaaabeaapmaabaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaabaiaabbaaadaaaaaaaaaaaaaaaaaaaabaecaaaaaaabaaaaaaadaaaaaaac
aaaaacjaaabaaaadaaaafaaeaacbfaafaaaadafaaaabdbfbaaaababeaaaabaao
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
maejapnleamjapnlaaaaaaaaaaaaaaaalpaaaaaadpaaaaaalpiaaaaadoccpjid
habfdaadaaaabcaamcaaaaaaaaaaeaagaaaabcaameaaaaaaaaaagaakfababcaa
ccaaaaaaafpidaaaaaaaagiiaaaaaaaaafpibaaaaaaaapmiaaaaaaaaafpicaaa
aaaaapmiaaaaaaaamiapaaaaaabliiaakbadaeaamiapaaaaaamgiiaakladadaa
miapaaaaaalbdejekladacaamiapiadoaagmaadekladabaamiacaaaaaagmblaa
cbafppaakieaabaaaaaaaaebmcaaaaaamiadaaaaaamflaaakaabppaacmeaaaaa
aaaaaalbocaaaaaamiadiaabaalalabkilacagagmiaeaaaaaamglbgmilaapopo
mabeababacgmlbmgkaabppaameciababaagmmgmgkbabppaamiadaaaaaagmlalb
mlaaabppmiadaaaaaabkmflaolababaamiadiaaaaalalabkilaaahahaaaaaaaa
aaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 467 [_Time]
Float 466 [_RotationSpeed]
Vector 465 [unity_LightmapST]
Vector 464 [_MainTex_ST]
"sce_vp_rsx // 18 instructions using 2 registers
[Configuration]
8
0000001203010200
[Defaults]
1
463 3
3f000000400000003f800000
[Microcode]
288
401f9c6c011d1908010400d740619fa000009c6c00dcf8800186c08200419ffc
401f9c6c01d0300d8106c0c360403f8000001c6c005d30000186c08360411ffc
00001c6c009d2000008000c360409ffc401f9c6c79d0200d8106c0caa0304000
401f9c6c81d0100d8106c0caa024800000001c6c004000800086c08360403ffc
00001c6c004000550086c08360409ffc00001c6c011cf008008000c000619ffc
00001c6c011cf055808000c000607ffc00001c6c011cf008009540f540619ffc
00001c6c011cf055809540f540607ffc00001c6c0080002a8284004360419ffc
00001c6c0100000002ae804200219ffc00001c6c00dcf0000186c08200219ffc
401f9c6c01d0000d8106c0c360411f80401f9c6c011d0008008400d740619f9d
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 96 // 96 used size, 6 vars
Float 48 [_RotationSpeed]
Vector 64 [unity_LightmapST] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 16 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbpmklacakjbgempkhdmgjhmcggjanbidabaaaaaaeaaeaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneacaaaaeaaaabaalfaaaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaa
aaaaaaaaadaaaaaaakiacaaaabaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaabaaaaaaakaabaaaaaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaa
aaaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaalpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
dcaaaaaphcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaak
dcaabaaaabaaaaaaegbabaaaadaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaa
aaaaaaaaapaaaaahbcaabaaaacaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaa
apaaaaahccaabaaaacaaaaaabgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp float _RotationSpeed;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = _glesMultiTexCoord0.zw;
  tmpvar_1.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_2;
  tmpvar_2 = sin((_RotationSpeed * _Time));
  highp float tmpvar_3;
  tmpvar_3 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_4;
  tmpvar_4[0].x = tmpvar_3;
  tmpvar_4[0].y = tmpvar_2.x;
  tmpvar_4[1].x = -(tmpvar_2.x);
  tmpvar_4[1].y = tmpvar_3;
  tmpvar_1.xy = (tmpvar_1.xy * ((((tmpvar_4 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_1.xy = (tmpvar_1.xy + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = c_4.xyz;
  tmpvar_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = c_4.w;
  tmpvar_3 = tmpvar_7;
  c_1.xyz = (tmpvar_2 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp float _RotationSpeed;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = _glesMultiTexCoord0.zw;
  tmpvar_1.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_2;
  tmpvar_2 = sin((_RotationSpeed * _Time));
  highp float tmpvar_3;
  tmpvar_3 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_4;
  tmpvar_4[0].x = tmpvar_3;
  tmpvar_4[0].y = tmpvar_2.x;
  tmpvar_4[1].x = -(tmpvar_2.x);
  tmpvar_4[1].y = tmpvar_3;
  tmpvar_1.xy = (tmpvar_1.xy * ((((tmpvar_4 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_1.xy = (tmpvar_1.xy + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = c_4.xyz;
  tmpvar_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = c_4.w;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  c_1.xyz = (tmpvar_2 * ((8.0 * tmpvar_8.w) * tmpvar_8.xyz));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Float 9 [_RotationSpeed]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
"agal_vs
c12 -0.5 0.159155 0.5 0.0
c13 6.283185 -3.141593 2.0 -1.0
c14 -0.000002 -0.000022 0.002604 0.00026
c15 -0.020833 -0.125 1.0 0.5
[bc]
aaaaaaaaaaaaabacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c9
adaaaaaaaaaaabacaiaaaaoeabaaaaaaaaaaaaaaacaaaaaa mul r0.x, c8, r0.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaaamaaaaffabaaaaaa mul r0.x, r0.x, c12.y
abaaaaaaaaaaabacaaaaaaaaacaaaaaaamaaaakkabaaaaaa add r0.x, r0.x, c12.z
aiaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa frc r0.x, r0.x
adaaaaaaabaaabacaaaaaaaaacaaaaaaanaaaaoeabaaaaaa mul r1.x, r0.x, c13
abaaaaaaabaaabacabaaaaaaacaaaaaaanaaaaffabaaaaaa add r1.x, r1.x, c13.y
apaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sin r0.x, r1.x
baaaaaaaaaaaacacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa cos r0.y, r1.x
adaaaaaaaaaaamacaaaaaabaacaaaaaaamaaaakkabaaaaaa mul r0.zw, r0.xxyx, c12.z
abaaaaaaaaaaamacaaaaaaopacaaaaaaamaaaakkabaaaaaa add r0.zw, r0.wwzw, c12.z
adaaaaaaabaaadacaaaaaapoacaaaaaaanaaaakkabaaaaaa mul r1.xy, r0.zwww, c13.z
abaaaaaaabaaadacabaaaafeacaaaaaaanaaaappabaaaaaa add r1.xy, r1.xyyy, c13.w
abaaaaaaaaaaamacadaaaaeeaaaaaaaaamaaaaaaabaaaaaa add r0.zw, a3.xyxy, c12.x
bfaaaaaaaaaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r0.y
adaaaaaaaaaaadacaaaaaafeacaaaaaaamaaaakkabaaaaaa mul r0.xy, r0.xyyy, c12.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaamaaaakkabaaaaaa add r0.xy, r0.xyyy, c12.z
adaaaaaaabaaadacaaaaaappacaaaaaaabaaaafeacaaaaaa mul r1.xy, r0.w, r1.xyyy
adaaaaaaaaaaadacaaaaaafeacaaaaaaanaaaakkabaaaaaa mul r0.xy, r0.xyyy, c13.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaanaaaappabaaaaaa add r0.xy, r0.xyyy, c13.w
adaaaaaaaaaaadacaaaaaakkacaaaaaaaaaaaafeacaaaaaa mul r0.xy, r0.z, r0.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaafeacaaaaaa add r0.xy, r0.xyyy, r1.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaamaaaakkabaaaaaa add r0.xy, r0.xyyy, c12.z
adaaaaaaaaaaadacaaaaaafeacaaaaaaalaaaaoeabaaaaaa mul r0.xy, r0.xyyy, c11
abaaaaaaaaaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v0.xy, r0.xyyy, c11.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaakaaaaoeabaaaaaa mul r0.xy, a4, c10
abaaaaaaabaaadaeaaaaaafeacaaaaaaakaaaaooabaaaaaa add v1.xy, r0.xyyy, c10.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 96 // 96 used size, 6 vars
Float 48 [_RotationSpeed]
Vector 64 [unity_LightmapST] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 16 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedcdjanldmljldnmkhbalagpicnffpidfpabaaaaaammagaaaaaeaaaaaa
daaaaaaaliacaaaajeafaaaafmagaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
deacaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaadaa
adaaabaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafajaaapkaaaaaaalpidpjccdoaaaaaadpaaaaiado
fbaaaaafakaaapkanlapmjeanlapejmagdibihlekblfmpdhfbaaaaafalaaapka
lkajlglkkekkckdnaaaaiadpaaaaaamabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaabiaabaaaaka
afaaaaadaaaaabiaaaaaaaiaaeaaaakaaeaaaaaeaaaaapiaaaaaaaiaajaaffka
ajaalokabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiaakaaaaka
akaaffkaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeabaaapiaaaaaolia
akaakkkaakaappkaaeaaaaaeabaaapiaaaaaoliaabaaoeiaalaaaakaaeaaaaae
abaaapiaaaaaoliaabaaoeiaalaaffkaaeaaaaaeabaaapiaaaaaoliaabaaoeia
ajaaaakaaeaaaaaeaaaaapiaaaaaoeiaabaaoeiaalaakkkaaeaaaaaeaaaaapia
aaaaoeiaajaaikkaajaakkkaaeaaaaaeaaaaapiaaaaaoeiaalaappkbalaakkkb
acaaaaadabaaapiaadaaeejaajaaaakaafaaaaadaaaaapiaaaaaoeiaabaaoeia
acaaaaadaaaaadiaaaaaoniaaaaaoiiaacaaaaadaaaaadiaaaaaoeiaajaakkka
aeaaaaaeaaaaadoaaaaaoeiaadaaoekaadaaookaaeaaaaaeaaaaamoaaeaabeja
acaabekaacaalekaafaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapia
afaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcneacaaaa
eaaaabaalfaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaaakiacaaa
abaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaa
aaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaa
adaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaa
acaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaa
bgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
aeaaaaaakgiocaaaaaaaaaaaaeaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
giaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec2 lmap;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 423
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
#line 436
uniform sampler2D unity_Lightmap;
#line 398
void vert( inout appdata_full v ) {
    v.texcoord.xy -= 0.5;
    #line 401
    highp float s = float( sin((_RotationSpeed * _Time)));
    highp float c = float( cos((_RotationSpeed * _Time)));
    highp mat2 rotationMatrix = mat2( c, s, (-s), c);
    rotationMatrix *= 0.5;
    #line 405
    rotationMatrix += 0.5;
    rotationMatrix = ((rotationMatrix * 2.0) - 1.0);
    v.texcoord.xy = (v.texcoord.xy * rotationMatrix);
    v.texcoord.xy += 0.5;
}
#line 425
v2f_surf vert_surf( in appdata_full v ) {
    #line 427
    v2f_surf o;
    vert( v);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    #line 431
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec2 lmap;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 423
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
#line 436
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 410
void surf( in Input IN, inout SurfaceOutput o ) {
    mediump vec4 c = texture( _MainTex, IN.uv_MainTex);
    o.Albedo = c.xyz;
    #line 414
    o.Alpha = c.w;
}
#line 437
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 440
    surfIN.uv_MainTex = IN.pack0.xy;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 444
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 448
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    #line 452
    c.xyz += (o.Albedo * lm);
    c.w = o.Alpha;
    c.w = o.Alpha;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_Time]
Float 10 [_RotationSpeed]
Vector 11 [unity_LightmapST]
Vector 12 [_MainTex_ST]
"!!ARBvp1.0
# 50 ALU
PARAM c[17] = { { 0.5, 24.980801, -24.980801, 0.15915491 },
		state.matrix.mvp,
		program.local[5..12],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75, 0.25, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[9];
MUL R0.x, R0, c[10];
MUL R0.x, R0, c[0].w;
FRC R1.w, R0.x;
ADD R0.y, R0.x, -c[16].z;
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[13];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].yzyw;
ADD R0.xyz, -R1.w, c[13];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].yzyw;
ADD R1.xyz, R1, c[14].xyxw;
MAD R1.xyz, R1, R0, c[14].zwzw;
MAD R1.xyz, R1, R0, c[15].xyxw;
MAD R1.xyz, R1, R0, c[15].zwzw;
ADD R3.xyz, R3, c[14].xyxw;
MAD R3.xyz, R3, R2, c[14].zwzw;
MAD R3.xyz, R3, R2, c[15].xyxw;
MAD R1.xyz, R1, R0, c[13].wzww;
MAD R3.xyz, R3, R2, c[15].zwzw;
SLT R4.x, R1.w, c[16].z;
SGE R4.yz, R1.w, c[16].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[13].wzww;
DP3 R4.x, R1, -R0;
MAD R1.xyz, R3, R2, c[13].wzww;
SLT R0.x, R0.w, c[16].z;
SGE R0.yz, R0.w, c[16].xxyw;
DP3 R2.y, R0, c[13].wzww;
MOV R2.xz, R0;
DP3 R0.x, R1, -R2;
MOV R4.y, -R0.x;
MOV R0.y, R4.x;
MAD R0.xy, R0, c[0].x, c[0].x;
MUL R0.zw, R0.xyxy, c[16].w;
MAD R1.xy, R4, c[0].x, c[0].x;
MUL R0.xy, R1, c[16].w;
ADD R1.xy, R0.zwzw, -c[13].z;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R1.xy, R0.w, R1;
ADD R0.xy, R0, -c[13].z;
MAD R0.xy, R0.z, R0, R1;
ADD R0.xy, R0, c[0].x;
MAD result.texcoord[0].xy, R0, c[12], c[12].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[11], c[11].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 50 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Float 9 [_RotationSpeed]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
"vs_2_0
; 30 ALU
def c12, -0.50000000, 0.15915491, 0.50000000, 0
def c13, 6.28318501, -3.14159298, 2.00000000, -1.00000000
def c14, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c15, -0.02083333, -0.12500000, 1.00000000, 0.50000000
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c9
mul r0.x, c8, r0
mad r0.x, r0, c12.y, c12.z
frc r0.x, r0
mad r1.x, r0, c13, c13.y
sincos r0.xy, r1.x, c14.xyzw, c15.xyzw
mad r0.zw, r0.xyyx, c12.z, c12.z
mad r1.xy, r0.zwzw, c13.z, c13.w
add r0.zw, v3.xyxy, c12.x
mov r0.y, -r0
mad r0.xy, r0, c12.z, c12.z
mul r1.xy, r0.w, r1
mad r0.xy, r0, c13.z, c13.w
mad r0.xy, r0.z, r0, r1
add r0.xy, r0, c12.z
mad oT0.xy, r0, c11, c11.zwzw
mad oT1.xy, v4, c10, c10.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 7 [_MainTex_ST]
Float 5 [_RotationSpeed]
Vector 0 [_Time]
Matrix 1 [glstate_matrix_mvp] 4
Vector 6 [unity_LightmapST]
// Shader Timing Estimate, in Cycles/64 vertex vector:
// ALU: 20.00 (15 instructions), vertex: 32, texture: 0,
//   sequencer: 12,  4 GPRs, 31 threads,
// Performance (if enough threads): ~32 cycles per vector
// * Vertex cycle estimates are assuming 3 vfetch_minis for every vfetch_full,
//     with <= 32 bytes per vfetch_full group.

"vs_360
backbbabaaaaabkaaaaaabeiaaaaaaaaaaaaaaceaaaaabdeaaaaabfmaaaaaaaa
aaaaaaaaaaaaabamaaaaaabmaaaaabaapppoadaaaaaaaaafaaaaaabmaaaaaaaa
aaaaaapjaaaaaaiaaaacaaahaaabaaaaaaaaaaimaaaaaaaaaaaaaajmaaacaaaf
aaabaaaaaaaaaakmaaaaaaaaaaaaaalmaaacaaaaaaabaaaaaaaaaaimaaaaaaaa
aaaaaamcaaacaaabaaaeaaaaaaaaaaniaaaaaaaaaaaaaaoiaaacaaagaaabaaaa
aaaaaaimaaaaaaaafpengbgjgofegfhifpfdfeaaaaabaaadaaabaaaeaaabaaaa
aaaaaaaafpfcgphegbhegjgpgofdhagfgfgeaaklaaaaaaadaaabaaabaaabaaaa
aaaaaaaafpfegjgngfaaghgmhdhegbhegffpgngbhehcgjhifpgnhghaaaklklkl
aaadaaadaaaeaaaeaaabaaaaaaaaaaaahfgogjhehjfpemgjghgihegngbhafdfe
aahghdfpddfpdaaadccodacodcdadddfddcodaaaaaaaaaaaaaaaaaabaaaaaaaa
aaaaaaaaaaaaaabeaapmaabaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaabaiaabbaaadaaaaaaaaaaaaaaaaaaaabaecaaaaaaabaaaaaaadaaaaaaac
aaaaacjaaabaaaadaaaafaaeaacbfaafaaaadafaaaabdbfbaaaababeaaaabaao
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
maejapnleamjapnlaaaaaaaaaaaaaaaalpaaaaaadpaaaaaalpiaaaaadoccpjid
habfdaadaaaabcaamcaaaaaaaaaaeaagaaaabcaameaaaaaaaaaagaakfababcaa
ccaaaaaaafpidaaaaaaaagiiaaaaaaaaafpibaaaaaaaapmiaaaaaaaaafpicaaa
aaaaapmiaaaaaaaamiapaaaaaabliiaakbadaeaamiapaaaaaamgiiaakladadaa
miapaaaaaalbdejekladacaamiapiadoaagmaadekladabaamiacaaaaaagmblaa
cbafppaakieaabaaaaaaaaebmcaaaaaamiadaaaaaamflaaakaabppaacmeaaaaa
aaaaaalbocaaaaaamiadiaabaalalabkilacagagmiaeaaaaaamglbgmilaapopo
mabeababacgmlbmgkaabppaameciababaagmmgmgkbabppaamiadaaaaaagmlalb
mlaaabppmiadaaaaaabkmflaolababaamiadiaaaaalalabkilaaahahaaaaaaaa
aaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 467 [_Time]
Float 466 [_RotationSpeed]
Vector 465 [unity_LightmapST]
Vector 464 [_MainTex_ST]
"sce_vp_rsx // 18 instructions using 2 registers
[Configuration]
8
0000001203010200
[Defaults]
1
463 3
3f000000400000003f800000
[Microcode]
288
401f9c6c011d1908010400d740619fa000009c6c00dcf8800186c08200419ffc
401f9c6c01d0300d8106c0c360403f8000001c6c005d30000186c08360411ffc
00001c6c009d2000008000c360409ffc401f9c6c79d0200d8106c0caa0304000
401f9c6c81d0100d8106c0caa024800000001c6c004000800086c08360403ffc
00001c6c004000550086c08360409ffc00001c6c011cf008008000c000619ffc
00001c6c011cf055808000c000607ffc00001c6c011cf008009540f540619ffc
00001c6c011cf055809540f540607ffc00001c6c0080002a8284004360419ffc
00001c6c0100000002ae804200219ffc00001c6c00dcf0000186c08200219ffc
401f9c6c01d0000d8106c0c360411f80401f9c6c011d0008008400d740619f9d
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 96 // 96 used size, 6 vars
Float 48 [_RotationSpeed]
Vector 64 [unity_LightmapST] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 16 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbpmklacakjbgempkhdmgjhmcggjanbidabaaaaaaeaaeaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneacaaaaeaaaabaalfaaaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaa
aaaaaaaaadaaaaaaakiacaaaabaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaabaaaaaaakaabaaaaaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaa
aaaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaalpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
dcaaaaaphcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaak
dcaabaaaabaaaaaaegbabaaaadaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaa
aaaaaaaaapaaaaahbcaabaaaacaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaa
apaaaaahccaabaaaacaaaaaabgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp float _RotationSpeed;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = _glesMultiTexCoord0.zw;
  tmpvar_1.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_2;
  tmpvar_2 = sin((_RotationSpeed * _Time));
  highp float tmpvar_3;
  tmpvar_3 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_4;
  tmpvar_4[0].x = tmpvar_3;
  tmpvar_4[0].y = tmpvar_2.x;
  tmpvar_4[1].x = -(tmpvar_2.x);
  tmpvar_4[1].y = tmpvar_3;
  tmpvar_1.xy = (tmpvar_1.xy * ((((tmpvar_4 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_1.xy = (tmpvar_1.xy + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = c_4.xyz;
  tmpvar_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = c_4.w;
  tmpvar_3 = tmpvar_7;
  mediump vec3 lm_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_8 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_2 * lm_8);
  c_1.xyz = tmpvar_10;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp float _RotationSpeed;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = _glesMultiTexCoord0.zw;
  tmpvar_1.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_2;
  tmpvar_2 = sin((_RotationSpeed * _Time));
  highp float tmpvar_3;
  tmpvar_3 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_4;
  tmpvar_4[0].x = tmpvar_3;
  tmpvar_4[0].y = tmpvar_2.x;
  tmpvar_4[1].x = -(tmpvar_2.x);
  tmpvar_4[1].y = tmpvar_3;
  tmpvar_1.xy = (tmpvar_1.xy * ((((tmpvar_4 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_1.xy = (tmpvar_1.xy + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = c_4.xyz;
  tmpvar_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = c_4.w;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((8.0 * tmpvar_8.w) * tmpvar_8.xyz);
  lm_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_2 * lm_9);
  c_1.xyz = tmpvar_11;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Float 9 [_RotationSpeed]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
"agal_vs
c12 -0.5 0.159155 0.5 0.0
c13 6.283185 -3.141593 2.0 -1.0
c14 -0.000002 -0.000022 0.002604 0.00026
c15 -0.020833 -0.125 1.0 0.5
[bc]
aaaaaaaaaaaaabacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c9
adaaaaaaaaaaabacaiaaaaoeabaaaaaaaaaaaaaaacaaaaaa mul r0.x, c8, r0.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaaamaaaaffabaaaaaa mul r0.x, r0.x, c12.y
abaaaaaaaaaaabacaaaaaaaaacaaaaaaamaaaakkabaaaaaa add r0.x, r0.x, c12.z
aiaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa frc r0.x, r0.x
adaaaaaaabaaabacaaaaaaaaacaaaaaaanaaaaoeabaaaaaa mul r1.x, r0.x, c13
abaaaaaaabaaabacabaaaaaaacaaaaaaanaaaaffabaaaaaa add r1.x, r1.x, c13.y
apaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sin r0.x, r1.x
baaaaaaaaaaaacacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa cos r0.y, r1.x
adaaaaaaaaaaamacaaaaaabaacaaaaaaamaaaakkabaaaaaa mul r0.zw, r0.xxyx, c12.z
abaaaaaaaaaaamacaaaaaaopacaaaaaaamaaaakkabaaaaaa add r0.zw, r0.wwzw, c12.z
adaaaaaaabaaadacaaaaaapoacaaaaaaanaaaakkabaaaaaa mul r1.xy, r0.zwww, c13.z
abaaaaaaabaaadacabaaaafeacaaaaaaanaaaappabaaaaaa add r1.xy, r1.xyyy, c13.w
abaaaaaaaaaaamacadaaaaeeaaaaaaaaamaaaaaaabaaaaaa add r0.zw, a3.xyxy, c12.x
bfaaaaaaaaaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r0.y
adaaaaaaaaaaadacaaaaaafeacaaaaaaamaaaakkabaaaaaa mul r0.xy, r0.xyyy, c12.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaamaaaakkabaaaaaa add r0.xy, r0.xyyy, c12.z
adaaaaaaabaaadacaaaaaappacaaaaaaabaaaafeacaaaaaa mul r1.xy, r0.w, r1.xyyy
adaaaaaaaaaaadacaaaaaafeacaaaaaaanaaaakkabaaaaaa mul r0.xy, r0.xyyy, c13.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaanaaaappabaaaaaa add r0.xy, r0.xyyy, c13.w
adaaaaaaaaaaadacaaaaaakkacaaaaaaaaaaaafeacaaaaaa mul r0.xy, r0.z, r0.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaafeacaaaaaa add r0.xy, r0.xyyy, r1.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaamaaaakkabaaaaaa add r0.xy, r0.xyyy, c12.z
adaaaaaaaaaaadacaaaaaafeacaaaaaaalaaaaoeabaaaaaa mul r0.xy, r0.xyyy, c11
abaaaaaaaaaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v0.xy, r0.xyyy, c11.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaakaaaaoeabaaaaaa mul r0.xy, a4, c10
abaaaaaaabaaadaeaaaaaafeacaaaaaaakaaaaooabaaaaaa add v1.xy, r0.xyyy, c10.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 96 // 96 used size, 6 vars
Float 48 [_RotationSpeed]
Vector 64 [unity_LightmapST] 4
Vector 80 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 16 instructions, 3 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedcdjanldmljldnmkhbalagpicnffpidfpabaaaaaammagaaaaaeaaaaaa
daaaaaaaliacaaaajeafaaaafmagaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
deacaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaadaa
adaaabaaaaaaaaaaabaaaaaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafajaaapkaaaaaaalpidpjccdoaaaaaadpaaaaiado
fbaaaaafakaaapkanlapmjeanlapejmagdibihlekblfmpdhfbaaaaafalaaapka
lkajlglkkekkckdnaaaaiadpaaaaaamabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaabaaaaacaaaaabiaabaaaaka
afaaaaadaaaaabiaaaaaaaiaaeaaaakaaeaaaaaeaaaaapiaaaaaaaiaajaaffka
ajaalokabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeiaakaaaaka
akaaffkaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeabaaapiaaaaaolia
akaakkkaakaappkaaeaaaaaeabaaapiaaaaaoliaabaaoeiaalaaaakaaeaaaaae
abaaapiaaaaaoliaabaaoeiaalaaffkaaeaaaaaeabaaapiaaaaaoliaabaaoeia
ajaaaakaaeaaaaaeaaaaapiaaaaaoeiaabaaoeiaalaakkkaaeaaaaaeaaaaapia
aaaaoeiaajaaikkaajaakkkaaeaaaaaeaaaaapiaaaaaoeiaalaappkbalaakkkb
acaaaaadabaaapiaadaaeejaajaaaakaafaaaaadaaaaapiaaaaaoeiaabaaoeia
acaaaaadaaaaadiaaaaaoniaaaaaoiiaacaaaaadaaaaadiaaaaaoeiaajaakkka
aeaaaaaeaaaaadoaaaaaoeiaadaaoekaadaaookaaeaaaaaeaaaaamoaaeaabeja
acaabekaacaalekaafaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapia
afaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcneacaaaa
eaaaabaalfaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaaakiacaaa
abaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaa
aaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaa
adaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaa
acaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaa
bgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
aeaaaaaakgiocaaaaaaaaaaaaeaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
giaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec2 lmap;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 423
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
#line 436
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 398
void vert( inout appdata_full v ) {
    v.texcoord.xy -= 0.5;
    #line 401
    highp float s = float( sin((_RotationSpeed * _Time)));
    highp float c = float( cos((_RotationSpeed * _Time)));
    highp mat2 rotationMatrix = mat2( c, s, (-s), c);
    rotationMatrix *= 0.5;
    #line 405
    rotationMatrix += 0.5;
    rotationMatrix = ((rotationMatrix * 2.0) - 1.0);
    v.texcoord.xy = (v.texcoord.xy * rotationMatrix);
    v.texcoord.xy += 0.5;
}
#line 425
v2f_surf vert_surf( in appdata_full v ) {
    #line 427
    v2f_surf o;
    vert( v);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    #line 431
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec2 lmap;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 423
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
#line 436
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 353
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 355
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 410
void surf( in Input IN, inout SurfaceOutput o ) {
    mediump vec4 c = texture( _MainTex, IN.uv_MainTex);
    o.Albedo = c.xyz;
    #line 414
    o.Alpha = c.w;
}
#line 438
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 440
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 444
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 448
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 452
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, false).xyz;
    c.xyz += (o.Albedo * lm);
    c.w = o.Alpha;
    #line 456
    c.w = o.Alpha;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_Time]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Matrix 5 [_Object2World]
Vector 25 [unity_Scale]
Float 26 [_RotationSpeed]
Vector 27 [_MainTex_ST]
"!!ARBvp1.0
# 99 ALU
PARAM c[32] = { { 0.5, 0.15915491, 0, 1 },
		state.matrix.mvp,
		program.local[5..27],
		{ 24.980801, -24.980801, -60.145809, 60.145809 },
		{ 85.453789, -85.453789, -64.939346, 64.939346 },
		{ 19.73921, -19.73921, -1, 1 },
		{ -9, 0.75, 0.25, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[25].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R5.w, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[11];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[10];
MUL R1, R1, R1;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[12];
MAD R1, R0, R0, R1;
MAD R0, R5.w, R0, R2;
MUL R2, R1, c[13];
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].w;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].z;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[15];
MAD R1.xyz, R0.x, c[14], R1;
MOV R1.w, c[9].x;
MUL R0.y, R1.w, c[26].x;
MUL R0.x, R0.y, c[0].y;
FRC R2.w, R0.x;
ADD R0.y, R0.x, -c[31].z;
FRC R1.w, R0.y;
MAD R5.xyz, R0.z, c[16], R1;
ADD R1.xyz, -R1.w, c[0].zxww;
MUL R2.xyz, R1, R1;
MAD R3.xyz, R2, c[28].xyxw, c[28].zwzw;
MAD R3.xyz, R3, R2, c[29].xyxw;
MAD R3.xyz, R3, R2, c[29].zwzw;
ADD R0.xyz, -R2.w, c[0].zxww;
MUL R0.xyz, R0, R0;
MAD R1.xyz, R0, c[28].xyxw, c[28].zwzw;
MAD R1.xyz, R1, R0, c[29].xyxw;
MAD R1.xyz, R1, R0, c[29].zwzw;
MAD R1.xyz, R1, R0, c[30].xyxw;
MAD R3.xyz, R3, R2, c[30].xyxw;
MAD R1.xyz, R1, R0, c[30].zwzw;
SGE R4.zw, R2.w, c[31].xyxy;
SLT R4.y, R2.w, c[31].z;
DP3 R0.y, R4.yzww, c[30].zwzw;
MOV R0.xz, R4.yyww;
DP3 R4.z, R1, -R0;
MAD R0.xyz, R3, R2, c[30].zwzw;
SLT R1.x, R1.w, c[31].z;
SGE R1.yz, R1.w, c[31].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[30].zwzw;
DP3 R0.x, R0, -R2;
MOV R0.y, R4.z;
MAD R1.xy, R0, c[0].x, c[0].x;
MOV R4.w, -R0.x;
MAD R0.xy, R4.zwzw, c[0].x, c[0].x;
MUL R1.zw, R1.xyxy, c[31].w;
MUL R1.xy, R0, c[31].w;
ADD R0.xy, R1.zwzw, -c[0].w;
ADD R1.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R0.xy, R1.w, R0;
ADD R1.xy, R1, -c[0].w;
MAD R0.xy, R1.z, R1, R0;
MAD R1.xyz, R0.w, c[17], R5;
ADD R5.xy, R0, c[0].x;
MUL R1.w, R3, R3;
MOV R4.y, R3.w;
MOV R4.z, R5.w;
MUL R0, R4.xyzz, R4.yzzx;
MOV R4.w, c[0];
DP4 R3.z, R0, c[23];
DP4 R3.y, R0, c[22];
DP4 R3.x, R0, c[21];
MAD R1.w, R4.x, R4.x, -R1;
DP4 R2.z, R4, c[20];
DP4 R2.y, R4, c[19];
DP4 R2.x, R4, c[18];
MUL R0.xyz, R1.w, c[24];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MAD result.texcoord[0].xy, R5, c[27], c[27].zwzw;
MOV result.texcoord[1].z, R5.w;
MOV result.texcoord[1].y, R3.w;
MOV result.texcoord[1].x, R4;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 99 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Vector 9 [unity_4LightPosX0]
Vector 10 [unity_4LightPosY0]
Vector 11 [unity_4LightPosZ0]
Vector 12 [unity_4LightAtten0]
Vector 13 [unity_LightColor0]
Vector 14 [unity_LightColor1]
Vector 15 [unity_LightColor2]
Vector 16 [unity_LightColor3]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Matrix 4 [_Object2World]
Vector 24 [unity_Scale]
Float 25 [_RotationSpeed]
Vector 26 [_MainTex_ST]
"vs_2_0
; 82 ALU
def c27, -0.50000000, 0.15915491, 0.50000000, 1.00000000
def c28, 6.28318501, -3.14159298, 2.00000000, -1.00000000
def c29, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c30, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c31, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c24.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c10
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c9
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c27
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c11
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c12
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c27.w
mov r2.x, c25
mul r2.x, c8, r2
max r0, r0, c31.x
dp4 r2.z, r4, c19
dp4 r2.y, r4, c18
mad r2.x, r2, c27.y, c27.z
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.z, r1.z
rcp r1.w, r1.w
mul r1, r0, r1
frc r0.w, r2.x
mul r0.xyz, r1.y, c14
mad r0.w, r0, c28.x, c28.y
sincos r5.xy, r0.w, c29.xyzw, c30.xyzw
mad r0.xyz, r1.x, c13, r0
mad r0.xyz, r1.z, c15, r0
mad r1.xyz, r1.w, c16, r0
dp4 r2.x, r4, c17
mov r0.y, -r5
mov r0.x, r5
mad r5.zw, r0.xyxy, c27.z, c27.z
mul r0, r4.xyzz, r4.yzzx
dp4 r4.w, r0, c22
dp4 r4.z, r0, c21
dp4 r4.y, r0, c20
add r0.xyz, r2, r4.yzww
mad r4.zw, r5, c28.z, c28.w
mad r2.xy, r5.yxzw, c27.z, c27.z
mul r0.w, r3, r3
mad r2.xy, r2, c28.z, c28.w
add r5.zw, v3.xyxy, c27.x
mul r5.xy, r5.w, r2
mad r0.w, r4.x, r4.x, -r0
mul r2.xyz, r0.w, c23
add r0.xyz, r0, r2
mad r4.zw, r5.z, r4, r5.xyxy
add r2.xy, r4.zwzw, c27.z
add oT2.xyz, r0, r1
mad oT0.xy, r2, c26, c26.zwzw
mov oT1.z, r3.x
mov oT1.y, r3.w
mov oT1.x, r4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 26 [_MainTex_ST]
Matrix 20 [_Object2World] 4
Float 25 [_RotationSpeed]
Vector 0 [_Time]
Matrix 16 [glstate_matrix_mvp] 4
Vector 4 [unity_4LightAtten0]
Vector 1 [unity_4LightPosX0]
Vector 2 [unity_4LightPosY0]
Vector 3 [unity_4LightPosZ0]
Vector 5 [unity_LightColor0]
Vector 6 [unity_LightColor1]
Vector 7 [unity_LightColor2]
Vector 8 [unity_LightColor3]
Vector 11 [unity_SHAb]
Vector 10 [unity_SHAg]
Vector 9 [unity_SHAr]
Vector 14 [unity_SHBb]
Vector 13 [unity_SHBg]
Vector 12 [unity_SHBr]
Vector 15 [unity_SHC]
Vector 24 [unity_Scale]
// Shader Timing Estimate, in Cycles/64 vertex vector:
// ALU: 72.00 (54 instructions), vertex: 32, texture: 0,
//   sequencer: 26,  11 GPRs, 15 threads,
// Performance (if enough threads): ~72 cycles per vector
// * Vertex cycle estimates are assuming 3 vfetch_minis for every vfetch_full,
//     with <= 32 bytes per vfetch_full group.

"vs_360
backbbabaaaaadgmaaaaademaaaaaaaaaaaaaaceaaaaacpiaaaaadcaaaaaaaaa
aaaaaaaaaaaaacnaaaaaaabmaaaaacmdpppoadaaaaaaaabcaaaaaabmaaaaaaaa
aaaaaclmaaaaabieaaacaabkaaabaaaaaaaaabjaaaaaaaaaaaaaabkaaaacaabe
aaaeaaaaaaaaablaaaaaaaaaaaaaabmaaaacaabjaaabaaaaaaaaabnaaaaaaaaa
aaaaaboaaaacaaaaaaabaaaaaaaaabjaaaaaaaaaaaaaabogaaacaabaaaaeaaaa
aaaaablaaaaaaaaaaaaaabpjaaacaaaeaaabaaaaaaaaabjaaaaaaaaaaaaaacam
aaacaaabaaabaaaaaaaaabjaaaaaaaaaaaaaacboaaacaaacaaabaaaaaaaaabja
aaaaaaaaaaaaacdaaaacaaadaaabaaaaaaaaabjaaaaaaaaaaaaaacecaaacaaaf
aaaeaaaaaaaaacfeaaaaaaaaaaaaacgeaaacaaalaaabaaaaaaaaabjaaaaaaaaa
aaaaacgpaaacaaakaaabaaaaaaaaabjaaaaaaaaaaaaaachkaaacaaajaaabaaaa
aaaaabjaaaaaaaaaaaaaacifaaacaaaoaaabaaaaaaaaabjaaaaaaaaaaaaaacja
aaacaaanaaabaaaaaaaaabjaaaaaaaaaaaaaacjlaaacaaamaaabaaaaaaaaabja
aaaaaaaaaaaaackgaaacaaapaaabaaaaaaaaabjaaaaaaaaaaaaaaclaaaacaabi
aaabaaaaaaaaabjaaaaaaaaafpengbgjgofegfhifpfdfeaaaaabaaadaaabaaae
aaabaaaaaaaaaaaafpepgcgkgfgdhedcfhgphcgmgeaaklklaaadaaadaaaeaaae
aaabaaaaaaaaaaaafpfcgphegbhegjgpgofdhagfgfgeaaklaaaaaaadaaabaaab
aaabaaaaaaaaaaaafpfegjgngfaaghgmhdhegbhegffpgngbhehcgjhifpgnhgha
aahfgogjhehjfpdeemgjghgiheebhehegfgodaaahfgogjhehjfpdeemgjghgihe
fagphdfidaaahfgogjhehjfpdeemgjghgihefagphdfjdaaahfgogjhehjfpdeem
gjghgihefagphdfkdaaahfgogjhehjfpemgjghgiheedgpgmgphcaaklaaabaaad
aaabaaaeaaaiaaaaaaaaaaaahfgogjhehjfpfdeiebgcaahfgogjhehjfpfdeieb
ghaahfgogjhehjfpfdeiebhcaahfgogjhehjfpfdeiecgcaahfgogjhehjfpfdei
ecghaahfgogjhehjfpfdeiechcaahfgogjhehjfpfdeiedaahfgogjhehjfpfdgd
gbgmgfaahghdfpddfpdaaadccodacodcdadddfddcodaaaklaaaaaaaaaaaaaaab
aaaaaaaaaaaaaaaaaaaaaabeaapmaabaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaeaaaaaadamaacbaaakaaaaaaaaaaaaaaaaaaaacagdaaaaaaabaaaaaaad
aaaaaaadaaaaacjaaabaaaahaaaadaaiaacafaajaaaadafaaaabhbfbaaachcfc
aaaabadaaaaababhaaaabadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaamaejapnldpiaaaaaeamjapnlaaaaaaaadpaaaaaa
lpaaaaaalpiaaaaadoccpjidhabfdaahaaaabcaamcaaaaaaaaaaeaakaaaabcaa
meaaaaaaaaaagaaogabebcaabcaaaaaaaaaagabkgacabcaabcaaaaaaaaaagacg
gacmbcaabcaaaaaaaaaagadcgadibcaabcaaaaaaaaaacadoaaaaccaaaaaaaaaa
afpibaaaaaaaaembaaaaaaaaafpiaaaaaaaaaeehaaaaaaaaafpigaaaaaaaaoeh
aaaaaaaamiapaaacaamgiiaakbabbdaamiapaaacaabliiaaklabbcacmiapaaac
aagmdejeklabbbacmiapiadoaalbaadeklabbaacbeanaaaaaaafblgmibaabibj
amchaaacaamgleblibabbhppmiahaaadaablmaleklabbgackibhagacaablleeb
ibaabgaamiahaaacaamglemaklaabfacmiahaaadaagmleleklabbfadmiajaaab
aamelaaakaagppaamiaoaaaaaalbpmimklabbeadmiahaaajaagmlemaklaabeac
miahiaabaaleleaaocajajaaceipajaiaelbaagmkaaaabiacmbpaaakaemgaagm
kaaaacabmiaeaaabaagmmggmilaapopoaibpahacaeblaaggkaaaadajaicbahae
aadoanmbgpajajajaiecahaeaadoanlbgpakajajaiieahaeaadoanlmgpalajaj
aibeaaaaaakhkhgmkpahanajaiciaaaaaakhkhmgkpahaoajgecpabadaapipigb
obacacaamecpafacaapilbmgobacajabmiapaaadaajejepiolakakadmiapaaac
aajemgpiolakajacmiapaaacaajegmaaolaiajacmiapaaadaajejeaaolaiaiad
ficbaaaaaakhkhblkpahamidmabnafaaaakoopmgoaaeaaabmiahaaabaalblebo
klabapaamiapaaaeaajepilbiladaepofibaaaaaaaaaaagmocaaaaidfieeaaaf
aclbgmlbkaagppidfiiiaaafaagmmgmgkbafppidmiadaaadaabllagmmlabafpp
miadaaadaabkmflaolafafadmiadiaaaaalalabkiladbkbkmiapaaaaaapiaaaa
obacaaaaemipaaadaapiblmgkcaapoaeemecacaaaamgblgmobadaaaeemciacac
aagmmgblobadacaeembbaaacaabllblbobadacaemiaeaaaaaalbgmaaobadaaaa
kibhacaeaalmmaecibacahaikiciacaeaamgblicmbaeadaikieoacafaabgpmma
ibacafaibeahaaaaaabbmalbkbaaagafambiafaaaamgmggmobaaadadbeahaaaa
aabebamgoaafaaacamihacaaaamabalboaaaaeadmiahaaaaaamabaaaoaaaacaa
miahiaacaalemaaaoaabaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_Time]
Vector 466 [unity_4LightPosX0]
Vector 465 [unity_4LightPosY0]
Vector 464 [unity_4LightPosZ0]
Vector 463 [unity_4LightAtten0]
Vector 462 [unity_LightColor0]
Vector 461 [unity_LightColor1]
Vector 460 [unity_LightColor2]
Vector 459 [unity_LightColor3]
Vector 458 [unity_SHAr]
Vector 457 [unity_SHAg]
Vector 456 [unity_SHAb]
Vector 455 [unity_SHBr]
Vector 454 [unity_SHBg]
Vector 453 [unity_SHBb]
Vector 452 [unity_SHC]
Matrix 260 [_Object2World]
Vector 451 [unity_Scale]
Float 450 [_RotationSpeed]
Vector 449 [_MainTex_ST]
"sce_vp_rsx // 60 instructions using 8 registers
[Configuration]
8
0000003c01050800
[Defaults]
1
448 4
3f000000400000003f80000000000000
[Microcode]
960
00001c6c009c320c013fc0c36041dffc00031c6c00dc08800186c08200419ffc
401f9c6c01d0300d8106c0c360403f80401f9c6c01d0200d8106c0c360405f80
401f9c6c01d0100d8106c0c360409f8000011c6c005d30000186c08360411ffc
00011c6c01d0500d8106c0c360409ffc00001c6c01d0400d8106c0c360403ffc
00009c6c01d0600d8106c0c360411ffc00029c6c0150400c008600c360411ffc
00039c6c0150600c008600c360405ffc00021c6c0150500c008600c360403ffc
00009c6c00dd000d8186c0a000a1fffc00001c6c00dd200d8186c0bfe021fffc
00019c6c00dd100d8186c0aaa121fffc00031c6c009c2000048000c360405ffc
00011c6c0080007f8886c3436041fffc00019c6c0080000d8686c3436041fffc
00029c6c0080007f88bfc44360403ffc00029c6c0040007f8886c08360409ffc
00029c6c004000550e86c08360405ffc00011c6c010000000a86c0436121fffc
00019c6c0100000d8086c04361a1fffc00021c6c019c800c0a86c0c360405ffc
00021c6c819c900c0a86c0d5433083fc00021c6c799ca00c0a86c0d54325037c
00001c6c0080000d0a9a05436041fffc00029c6c010000000a80057fe2a09ffc
00039c6c004000d50c86c08360409ffc00031c6c004000000e86c08360403ffc
00011c6c010000550e86c1436121fffc00009c6c0100000d8286c14361a1fffc
00019c6c01dc500d8086c0c360405ffc00019c6c01dc600d8086c0c360409ffc
00019c6c01dc700d8086c0c360411ffc00029c6c011c00558c8000c000607ffc
00031c6c011c00008e8000c000607ffc00001c6c00c0000c0886c08301a1dffc
00019c6c009c402a8a8600c36041dffc00021c6c00c0000c0686c0830021dffc
401f9c6c21d0000d8106c0c000b10000401f9c6c204000550e86c08aa0a84020
00019c6c209cf00d8286c0d540a5e07c00009c6c011c005d0c9540f540619ffc
00029c6c011c00558a9540f540607ffc00019c6c00dc00550186c08361a1fffc
00029c6c2080002a8caac55fe0a2607c00029c6c010000000c80415562a07ffc
401f9c6c1040007f8886c08001b080a0401f9c6c104000000a86c08aa1a900a0
00001c6c1080000d8486c05541a5e0fc00001c6c129c000d80bfc0dfe1a3e0fc
00011c6c00dc00000186c09742a19ffc00001c6c0080000d8086c1436041fffc
401f9c6c011c1008048400d740619f9c00009c6c009cd02a808600c36041dffc
00009c6c011ce000008600c300a1dffc00001c6c011cc055008600c300a1dffc
00001c6c011cb07f808600c30021dffc401f9c6c00c0000c0886c0830021dfa5
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 80 // 80 used size, 5 vars
Float 48 [_RotationSpeed]
Vector 64 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 160 [unity_LightColor4] 4
Vector 176 [unity_LightColor5] 4
Vector 192 [unity_LightColor6] 4
Vector 208 [unity_LightColor7] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 56 instructions, 6 temp regs, 0 temp arrays:
// ALU 51 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgenlloffjpbidmejcioenmoacbjafldcabaaaaaaleajaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
daaiaaaaeaaaabaaamacaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaaakiacaaa
abaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaa
aaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaa
adaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaa
acaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaa
bgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaa
adaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaah
pcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaa
agaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaa
acaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaa
egaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaa
dcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaacaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
ajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaadaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = _glesMultiTexCoord0.zw;
  tmpvar_4.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_5;
  tmpvar_5 = sin((_RotationSpeed * _Time));
  highp float tmpvar_6;
  tmpvar_6 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_7;
  tmpvar_7[0].x = tmpvar_6;
  tmpvar_7[0].y = tmpvar_5.x;
  tmpvar_7[1].x = -(tmpvar_5.x);
  tmpvar_7[1].y = tmpvar_6;
  tmpvar_4.xy = (tmpvar_4.xy * ((((tmpvar_7 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_4.xy = (tmpvar_4.xy + 0.5);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  shlight_1 = tmpvar_11;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_26;
  tmpvar_26 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosX0 - tmpvar_26.x);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosY0 - tmpvar_26.y);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_26.z);
  highp vec4 tmpvar_30;
  tmpvar_30 = (((tmpvar_27 * tmpvar_27) + (tmpvar_28 * tmpvar_28)) + (tmpvar_29 * tmpvar_29));
  highp vec4 tmpvar_31;
  tmpvar_31 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_27 * tmpvar_9.x) + (tmpvar_28 * tmpvar_9.y)) + (tmpvar_29 * tmpvar_9.z)) * inversesqrt(tmpvar_30))) * (1.0/((1.0 + (tmpvar_30 * unity_4LightAtten0)))));
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_31.x) + (unity_LightColor[1].xyz * tmpvar_31.y)) + (unity_LightColor[2].xyz * tmpvar_31.z)) + (unity_LightColor[3].xyz * tmpvar_31.w)));
  tmpvar_3 = tmpvar_32;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_4.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = c_4.xyz;
  tmpvar_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = c_4.w;
  tmpvar_3 = tmpvar_7;
  lowp vec4 c_8;
  c_8.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_8.w = tmpvar_3;
  c_1.xyz = (c_8.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = _glesMultiTexCoord0.zw;
  tmpvar_4.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_5;
  tmpvar_5 = sin((_RotationSpeed * _Time));
  highp float tmpvar_6;
  tmpvar_6 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_7;
  tmpvar_7[0].x = tmpvar_6;
  tmpvar_7[0].y = tmpvar_5.x;
  tmpvar_7[1].x = -(tmpvar_5.x);
  tmpvar_7[1].y = tmpvar_6;
  tmpvar_4.xy = (tmpvar_4.xy * ((((tmpvar_7 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_4.xy = (tmpvar_4.xy + 0.5);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  shlight_1 = tmpvar_11;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_26;
  tmpvar_26 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosX0 - tmpvar_26.x);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosY0 - tmpvar_26.y);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_26.z);
  highp vec4 tmpvar_30;
  tmpvar_30 = (((tmpvar_27 * tmpvar_27) + (tmpvar_28 * tmpvar_28)) + (tmpvar_29 * tmpvar_29));
  highp vec4 tmpvar_31;
  tmpvar_31 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_27 * tmpvar_9.x) + (tmpvar_28 * tmpvar_9.y)) + (tmpvar_29 * tmpvar_9.z)) * inversesqrt(tmpvar_30))) * (1.0/((1.0 + (tmpvar_30 * unity_4LightAtten0)))));
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_31.x) + (unity_LightColor[1].xyz * tmpvar_31.y)) + (unity_LightColor[2].xyz * tmpvar_31.z)) + (unity_LightColor[3].xyz * tmpvar_31.w)));
  tmpvar_3 = tmpvar_32;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_4.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = c_4.xyz;
  tmpvar_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = c_4.w;
  tmpvar_3 = tmpvar_7;
  lowp vec4 c_8;
  c_8.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_8.w = tmpvar_3;
  c_1.xyz = (c_8.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Vector 9 [unity_4LightPosX0]
Vector 10 [unity_4LightPosY0]
Vector 11 [unity_4LightPosZ0]
Vector 12 [unity_4LightAtten0]
Vector 13 [unity_LightColor0]
Vector 14 [unity_LightColor1]
Vector 15 [unity_LightColor2]
Vector 16 [unity_LightColor3]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Matrix 4 [_Object2World]
Vector 24 [unity_Scale]
Float 25 [_RotationSpeed]
Vector 26 [_MainTex_ST]
"agal_vs
c27 -0.5 0.159155 0.5 1.0
c28 6.283185 -3.141593 2.0 -1.0
c29 -0.000002 -0.000022 0.002604 0.00026
c30 -0.020833 -0.125 1.0 0.5
c31 0.0 0.0 0.0 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaabiaaaappabaaaaaa mul r3.xyz, a1, c24.w
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaaakaaaaoeabaaaaaa add r1, r1.x, c10
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaajaaaaoeabaaaaaa add r0, r0.x, c9
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
aaaaaaaaaeaaaiacblaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c27
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaagaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r6, r0, r0
abaaaaaaabaaapacagaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r6, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaaalaaaaoeabaaaaaa add r0, r0.y, c11
adaaaaaaagaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r6, r0, r0
abaaaaaaabaaapacagaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r6, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaaamaaaaoeabaaaaaa mul r2, r1, c12
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaablaaaappabaaaaaa add r1, r2, c27.w
aaaaaaaaacaaabacbjaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.x, c25
adaaaaaaacaaabacaiaaaaoeabaaaaaaacaaaaaaacaaaaaa mul r2.x, c8, r2.x
ahaaaaaaaaaaapacaaaaaaoeacaaaaaabpaaaaaaabaaaaaa max r0, r0, c31.x
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r2.z, r4, c19
bdaaaaaaacaaacacaeaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r2.y, r4, c18
adaaaaaaacaaabacacaaaaaaacaaaaaablaaaaffabaaaaaa mul r2.x, r2.x, c27.y
abaaaaaaacaaabacacaaaaaaacaaaaaablaaaakkabaaaaaa add r2.x, r2.x, c27.z
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
adaaaaaaabaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r0, r1
aiaaaaaaaaaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa frc r0.w, r2.x
adaaaaaaaaaaahacabaaaaffacaaaaaaaoaaaaoeabaaaaaa mul r0.xyz, r1.y, c14
adaaaaaaaaaaaiacaaaaaappacaaaaaabmaaaaaaabaaaaaa mul r0.w, r0.w, c28.x
abaaaaaaaaaaaiacaaaaaappacaaaaaabmaaaaffabaaaaaa add r0.w, r0.w, c28.y
apaaaaaaafaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa sin r5.x, r0.w
baaaaaaaafaaacacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa cos r5.y, r0.w
adaaaaaaagaaahacabaaaaaaacaaaaaaanaaaaoeabaaaaaa mul r6.xyz, r1.x, c13
abaaaaaaaaaaahacagaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r6.xyzz, r0.xyzz
adaaaaaaagaaahacabaaaakkacaaaaaaapaaaaoeabaaaaaa mul r6.xyz, r1.z, c15
abaaaaaaaaaaahacagaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r6.xyzz, r0.xyzz
adaaaaaaabaaahacabaaaappacaaaaaabaaaaaoeabaaaaaa mul r1.xyz, r1.w, c16
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
bdaaaaaaacaaabacaeaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r2.x, r4, c17
bfaaaaaaaaaaacacafaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r5.y
aaaaaaaaaaaaabacafaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r5.x
adaaaaaaafaaamacaaaaaaefacaaaaaablaaaakkabaaaaaa mul r5.zw, r0.yyxy, c27.z
abaaaaaaafaaamacafaaaaopacaaaaaablaaaakkabaaaaaa add r5.zw, r5.wwzw, c27.z
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
bdaaaaaaaeaaaiacaaaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 r4.w, r0, c22
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 r4.z, r0, c21
bdaaaaaaaeaaacacaaaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r4.y, r0, c20
abaaaaaaaaaaahacacaaaakeacaaaaaaaeaaaapjacaaaaaa add r0.xyz, r2.xyzz, r4.yzww
adaaaaaaaeaaamacafaaaaopacaaaaaabmaaaakkabaaaaaa mul r4.zw, r5.wwzw, c28.z
abaaaaaaaeaaamacaeaaaaopacaaaaaabmaaaappabaaaaaa add r4.zw, r4.wwzw, c28.w
adaaaaaaacaaadacafaaaaabacaaaaaablaaaakkabaaaaaa mul r2.xy, r5.yxxx, c27.z
abaaaaaaacaaadacacaaaafeacaaaaaablaaaakkabaaaaaa add r2.xy, r2.xyyy, c27.z
adaaaaaaaaaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r0.w, r3.w, r3.w
adaaaaaaacaaadacacaaaafeacaaaaaabmaaaakkabaaaaaa mul r2.xy, r2.xyyy, c28.z
abaaaaaaacaaadacacaaaafeacaaaaaabmaaaappabaaaaaa add r2.xy, r2.xyyy, c28.w
abaaaaaaafaaamacadaaaaeeaaaaaaaablaaaaaaabaaaaaa add r5.zw, a3.xyxy, c27.x
adaaaaaaafaaadacafaaaappacaaaaaaacaaaafeacaaaaaa mul r5.xy, r5.w, r2.xyyy
adaaaaaaagaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r6.w, r4.x, r4.x
acaaaaaaaaaaaiacagaaaappacaaaaaaaaaaaappacaaaaaa sub r0.w, r6.w, r0.w
adaaaaaaacaaahacaaaaaappacaaaaaabhaaaaoeabaaaaaa mul r2.xyz, r0.w, c23
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
adaaaaaaaeaaamacafaaaakkacaaaaaaaeaaaaopacaaaaaa mul r4.zw, r5.z, r4.wwzw
abaaaaaaaeaaamacaeaaaaopacaaaaaaafaaaaefacaaaaaa add r4.zw, r4.wwzw, r5.yyxy
abaaaaaaacaaadacaeaaaapoacaaaaaablaaaakkabaaaaaa add r2.xy, r4.zwww, c27.z
abaaaaaaacaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v2.xyz, r0.xyzz, r1.xyzz
adaaaaaaagaaadacacaaaafeacaaaaaabkaaaaoeabaaaaaa mul r6.xy, r2.xyyy, c26
abaaaaaaaaaaadaeagaaaafeacaaaaaabkaaaaooabaaaaaa add v0.xy, r6.xyyy, c26.zwzw
aaaaaaaaabaaaeaeadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v1.z, r3.x
aaaaaaaaabaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v1.y, r3.w
aaaaaaaaabaaabaeaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v1.x, r4.x
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 80 // 80 used size, 5 vars
Float 48 [_RotationSpeed]
Vector 64 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 160 [unity_LightColor4] 4
Vector 176 [unity_LightColor5] 4
Vector 192 [unity_LightColor6] 4
Vector 208 [unity_LightColor7] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 56 instructions, 6 temp regs, 0 temp arrays:
// ALU 51 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedikodbejnhimgegnggeflginmfcnigpbcabaaaaaaieapaaaaaeaaaaaa
daaaaaaapmafaaaadeaoaaaapmaoaaaaebgpgodjmeafaaaameafaaaaaaacpopp
eiafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaadaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaacaaacaaaiaaaeaaaaaaaaaa
acaacgaaahaaamaaaaaaaaaaadaaaaaaaeaabdaaaaaaaaaaadaaamaaaeaabhaa
aaaaaaaaadaabeaaabaablaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbmaaapka
aaaaaalpidpjccdoaaaaaadpaaaaiadofbaaaaafbnaaapkanlapmjeanlapejma
gdibihlekblfmpdhfbaaaaafboaaapkalkajlglkkekkckdnaaaaiadpaaaaaama
fbaaaaafbpaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaabaaaaac
aaaaabiaabaaaakaafaaaaadaaaaabiaaaaaaaiaadaaaakaaeaaaaaeaaaaapia
aaaaaaiabmaaffkabmaalokabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapia
aaaaoeiabnaaaakabnaaffkaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaaeaaaaae
abaaapiaaaaaoliabnaakkkabnaappkaaeaaaaaeabaaapiaaaaaoliaabaaoeia
boaaaakaaeaaaaaeabaaapiaaaaaoliaabaaoeiaboaaffkaaeaaaaaeabaaapia
aaaaoliaabaaoeiabmaaaakaaeaaaaaeaaaaapiaaaaaoeiaabaaoeiaboaakkka
aeaaaaaeaaaaapiaaaaaoeiabmaaikkabmaakkkaaeaaaaaeaaaaapiaaaaaoeia
boaappkbboaakkkbacaaaaadabaaapiaadaaeejabmaaaakaafaaaaadaaaaapia
aaaaoeiaabaaoeiaacaaaaadaaaaadiaaaaaoniaaaaaoiiaacaaaaadaaaaadia
aaaaoeiabmaakkkaaeaaaaaeaaaaadoaaaaaoeiaacaaoekaacaaookaafaaaaad
aaaaahiaaaaaffjabiaaoekaaeaaaaaeaaaaahiabhaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabjaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabkaaoeka
aaaappjaaaaaoeiaacaaaaadabaaapiaaaaaffibafaaoekaafaaaaadacaaapia
abaaoeiaabaaoeiaacaaaaadadaaapiaaaaaaaibaeaaoekaacaaaaadaaaaapia
aaaakkibagaaoekaaeaaaaaeacaaapiaadaaoeiaadaaoeiaacaaoeiaaeaaaaae
acaaapiaaaaaoeiaaaaaoeiaacaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaac
aeaaaciaacaaffiaahaaaaacaeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappia
abaaaaacafaaaeiaboaakkkaaeaaaaaeacaaapiaacaaoeiaahaaoekaafaakkia
afaaaaadafaaahiaacaaoejablaappkaafaaaaadagaaahiaafaaffiabiaaoeka
aeaaaaaeafaaaliabhaakekaafaaaaiaagaakeiaaeaaaaaeafaaahiabjaaoeka
afaakkiaafaapeiaafaaaaadabaaapiaabaaoeiaafaaffiaaeaaaaaeabaaapia
adaaoeiaafaaaaiaabaaoeiaaeaaaaaeaaaaapiaaaaaoeiaafaakkiaabaaoeia
afaaaaadaaaaapiaaeaaoeiaaaaaoeiaalaaaaadaaaaapiaaaaaoeiabpaaaaka
agaaaaacabaaabiaacaaaaiaagaaaaacabaaaciaacaaffiaagaaaaacabaaaeia
acaakkiaagaaaaacabaaaiiaacaappiaafaaaaadaaaaapiaaaaaoeiaabaaoeia
afaaaaadabaaahiaaaaaffiaajaaoekaaeaaaaaeabaaahiaaiaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaahiaakaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahia
alaaoekaaaaappiaaaaaoeiaabaaaaacafaaaiiaboaakkkaajaaaaadabaaabia
amaaoekaafaaoeiaajaaaaadabaaaciaanaaoekaafaaoeiaajaaaaadabaaaeia
aoaaoekaafaaoeiaafaaaaadacaaapiaafaacjiaafaakeiaajaaaaadadaaabia
apaaoekaacaaoeiaajaaaaadadaaaciabaaaoekaacaaoeiaajaaaaadadaaaeia
bbaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiia
afaaffiaafaaffiaaeaaaaaeaaaaaiiaafaaaaiaafaaaaiaaaaappibabaaaaac
abaaahoaafaaoeiaaeaaaaaeabaaahiabcaaoekaaaaappiaabaaoeiaacaaaaad
acaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabeaaoekaaeaaaaae
aaaaapiabdaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabfaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabgaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
daaiaaaaeaaaabaaamacaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaaakiacaaa
abaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaa
aaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaa
adaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaa
acaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaa
bgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaa
adaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaah
pcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaa
agaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaa
acaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaa
egaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaa
dcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaacaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
ajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaadaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    lowp vec3 vlight;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 424
uniform highp vec4 _MainTex_ST;
#line 440
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 398
void vert( inout appdata_full v ) {
    v.texcoord.xy -= 0.5;
    #line 401
    highp float s = float( sin((_RotationSpeed * _Time)));
    highp float c = float( cos((_RotationSpeed * _Time)));
    highp mat2 rotationMatrix = mat2( c, s, (-s), c);
    rotationMatrix *= 0.5;
    #line 405
    rotationMatrix += 0.5;
    rotationMatrix = ((rotationMatrix * 2.0) - 1.0);
    v.texcoord.xy = (v.texcoord.xy * rotationMatrix);
    v.texcoord.xy += 0.5;
}
#line 425
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 428
    vert( v);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 432
    o.normal = worldN;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    #line 436
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD2 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    lowp vec3 vlight;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 424
uniform highp vec4 _MainTex_ST;
#line 440
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 410
void surf( in Input IN, inout SurfaceOutput o ) {
    mediump vec4 c = texture( _MainTex, IN.uv_MainTex);
    o.Albedo = c.xyz;
    #line 414
    o.Alpha = c.w;
}
#line 440
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 444
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 448
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    #line 452
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 456
    c.w = o.Alpha;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN.vlight = vec3(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 3
//   opengl - ALU: 6 to 8, TEX: 1 to 2
//   d3d9 - ALU: 5 to 8, TEX: 1 to 2
//   d3d11 - ALU: 3 to 6, TEX: 1 to 2, FLOW: 1 to 1
//   d3d11_9x - ALU: 3 to 6, TEX: 1 to 2, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 8 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R0, fragment.texcoord[2];
DP3 R1.w, fragment.texcoord[1], c[0];
MUL R0.xyz, R0, c[1];
MAX R1.w, R1, c[2].x;
MUL R0.xyz, R1.w, R0;
MAD result.color.xyz, R0, c[2].y, R1;
MOV result.color.w, R0;
END
# 8 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 8 ALU, 1 TEX
dcl_2d s0
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
texld r1, t0, s0
mul_pp r2.xyz, r1, t2
dp3_pp r0.x, t1, c0
mul_pp r1.xyz, r1, c1
max_pp r0.x, r0, c2
mul_pp r0.xyz, r0.x, r1
mad_pp r0.xyz, r0, c2.y, r2
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D
// Shader Timing Estimate, in Cycles/64 pixel vector:
// ALU: 8.00 (6 instructions), vertex: 0, texture: 4,
//   sequencer: 6, interpolator: 12;    4 GPRs, 48 threads,
// Performance (if enough threads): ~12 cycles per vector
// * Texture cycle estimates are assuming an 8bit/component texture with no
//     aniso or trilinear filtering.

"ps_360
backbbaaaaaaabdiaaaaaaliaaaaaaaaaaaaaaceaaaaaaoeaaaaabamaaaaaaaa
aaaaaaaaaaaaaalmaaaaaabmaaaaaalappppadaaaaaaaaadaaaaaabmaaaaaaaa
aaaaaakjaaaaaafiaaacaaabaaabaaaaaaaaaagiaaaaaaaaaaaaaahiaaadaaaa
aaabaaaaaaaaaaieaaaaaaaaaaaaaajeaaacaaaaaaabaaaaaaaaaagiaaaaaaaa
fpemgjghgiheedgpgmgphcdaaaklklklaaabaaadaaabaaaeaaabaaaaaaaaaaaa
fpengbgjgofegfhiaaklklklaaaeaaamaaabaaabaaabaaaaaaaaaaaafpfhgphc
gmgefdhagbgdgfemgjghgihefagphddaaahahdfpddfpdaaadccodacodcdadddf
ddcodaaaaaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaabeabpmaabaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaahibaaaadaaaaaaaaaeaaaaaaaa
aaaacagdaaahaaahaaaaaaabaaaadafaaaaahbfbaaaahcfcaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbaacaaaabcaa
meaaaaaaaaaagaadaaaaccaaaaaaaaaabaaidaabbpbppgiiaaaaeaaamiabaaaa
aaloloaalaabaaaabeiaiaaaaaaaaablocaaaaadmiaiaaaaaagmgmaakcaappaa
miahaaaaaamamaaaobadacaaaaihaaabaamamablkbadabaamiahiaaaaamablma
olabaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_MainTex] 2D
"sce_fp_rsx // 10 instructions using 2 registers
[Configuration]
24
ffffffff0001c0200007fff9000000000000840002000000
[Offsets]
2
_WorldSpaceLightPos0 1 0
00000010
_LightColor0 1 0
00000070
[Microcode]
160
a2840540c8011c9dc8020001c8003fe100000000000000000000000000000000
9e001700c8011c9dc8000001c8003fe11084090001081c9c00020000c8000001
00000000000000000000000000000000ce840240c8001c9dc8015001c8003fe1
0e800240c8001c9dc8020001c800000100000000000000000000000000000000
10800140c8001c9dc8000001c80000010e810440ff081c9dc9001001c9080001
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
ConstBuffer "$Globals" 80 // 32 used size, 5 vars
Vector 16 [_LightColor0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 0
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddikeaelncdlakdnpoailagpdgkbclmadabaaaaaagaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchaabaaaaeaaaaaaafmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaa
adaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhccabaaa
aaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_MainTex] 2D
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
adaaaaaaacaaahacabaaaakeacaaaaaaacaaaaoeaeaaaaaa mul r2.xyz, r1.xyzz, v2
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaaoeabaaaaaa dp3 r0.x, v1, c0
adaaaaaaabaaahacabaaaakeacaaaaaaabaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c1
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
ConstBuffer "$Globals" 80 // 32 used size, 5 vars
Vector 16 [_LightColor0] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 0
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedmidkojemglnadacoimbdofefhjjdofleabaaaaaahmadaaaaaeaaaaaa
daaaaaaaeiabaaaamaacaaaaeiadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
naaaaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaabaaaaaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaaiaaaaadabaaciiaabaaoela
abaaoekaalaaaaadacaaciiaabaappiaacaaaakaacaaaaadabaacbiaacaappia
acaappiaafaaaaadabaacoiaaaaabliaaaaablkaafaaaaadacaachiaaaaaoeia
acaaoelaaeaaaaaeaaaachiaabaabliaabaaaaiaacaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefchaabaaaaeaaaaaaafmaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaa
aaaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaa
adaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhccabaaa
aaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"!!ARBfp1.0
# 6 ALU, 2 TEX
PARAM c[1] = { { 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[0].x;
MOV result.color.w, R0;
END
# 6 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"ps_2_0
; 5 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c0, 8.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t1, s1
texld r1, t0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c0.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
// Shader Timing Estimate, in Cycles/64 pixel vector:
// ALU: 4.00 (3 instructions), vertex: 0, texture: 8,
//   sequencer: 6, interpolator: 8;    3 GPRs, 63 threads,
// Performance (if enough threads): ~8 cycles per vector
// * Texture cycle estimates are assuming an 8bit/component texture with no
//     aniso or trilinear filtering.

"ps_360
backbbaaaaaaaapmaaaaaakaaaaaaaaaaaaaaaceaaaaaakmaaaaaaneaaaaaaaa
aaaaaaaaaaaaaaieaaaaaabmaaaaaahgppppadaaaaaaaaacaaaaaabmaaaaaaaa
aaaaaagpaaaaaaeeaaadaaaaaaabaaaaaaaaaafaaaaaaaaaaaaaaagaaaadaaab
aaabaaaaaaaaaafaaaaaaaaafpengbgjgofegfhiaaklklklaaaeaaamaaabaaab
aaabaaaaaaaaaaaahfgogjhehjfpemgjghgihegngbhaaahahdfpddfpdaaadcco
dacodcdadddfddcodaaaklklaaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaabe
abpmaabaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaagabaaaacaa
aaaaaaaeaaaaaaaaaaaabaecaaadaaadaaaaaaabaaaadafaaaaadbfbaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafcaac
aaaabcaameaaaaaaaaaadaaeaaaaccaaaaaaaaaababibacbbpbppgiiaaaaeaaa
baaiaaabbpbppgiiaaaaeaaakmbaacaaaaaaaaedmcaaaappmiahaaabaagmmaaa
obacabaabeihiaaaaamamablobabaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"sce_fp_rsx // 5 instructions using 2 registers
[Configuration]
24
ffffffff0000c0200003ffff000000000000840002000000
[Microcode]
80
be001702c8011c9dc8000001c8003fe10e800240fe001c9dc8000001c8000001
9e021700c8011c9dc8000001c8003fe10e800240c8041c9dc9003001c8000001
10810140c8041c9dc8000001c8000001
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 7 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjhfhafjjnaalbeceabobhppjddgpebdoabaaaaaapiabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaabaaaaeaaaaaaaeiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"agal_ps
c0 8.0 0.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v1, s1 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c0.x
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 7 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedgpjknelcilakdmlmokglemddllgfnidgabaaaaaanmacaaaaaeaaaaaa
daaaaaaabaabaaaadiacaaaakiacaaaaebgpgodjniaaaaaaniaaaaaaaaacpppp
kmaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkaabaaaaacaaaaadiaaaaabllaecaaaaadaaaacpiaaaaaoeiaabaioeka
ecaaaaadabaacpiaaaaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaaaaka
afaaaaadaaaachiaaaaaoeiaaaaappiaafaaaaadabaachiaaaaaoeiaabaaoeia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefccaabaaaaeaaaaaaaeiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaabaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"!!ARBfp1.0
# 6 ALU, 2 TEX
PARAM c[1] = { { 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[0].x;
MOV result.color.w, R0;
END
# 6 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"ps_2_0
; 5 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c0, 8.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t1, s1
texld r1, t0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c0.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
// Shader Timing Estimate, in Cycles/64 pixel vector:
// ALU: 4.00 (3 instructions), vertex: 0, texture: 8,
//   sequencer: 6, interpolator: 8;    3 GPRs, 63 threads,
// Performance (if enough threads): ~8 cycles per vector
// * Texture cycle estimates are assuming an 8bit/component texture with no
//     aniso or trilinear filtering.

"ps_360
backbbaaaaaaaapmaaaaaakaaaaaaaaaaaaaaaceaaaaaakmaaaaaaneaaaaaaaa
aaaaaaaaaaaaaaieaaaaaabmaaaaaahgppppadaaaaaaaaacaaaaaabmaaaaaaaa
aaaaaagpaaaaaaeeaaadaaaaaaabaaaaaaaaaafaaaaaaaaaaaaaaagaaaadaaab
aaabaaaaaaaaaafaaaaaaaaafpengbgjgofegfhiaaklklklaaaeaaamaaabaaab
aaabaaaaaaaaaaaahfgogjhehjfpemgjghgihegngbhaaahahdfpddfpdaaadcco
dacodcdadddfddcodaaaklklaaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaabe
abpmaabaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaagabaaaacaa
aaaaaaaeaaaaaaaaaaaabaecaaadaaadaaaaaaabaaaadafaaaaadbfbaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafcaac
aaaabcaameaaaaaaaaaadaaeaaaaccaaaaaaaaaababibacbbpbppgiiaaaaeaaa
baaiaaabbpbppgiiaaaaeaaakmbaacaaaaaaaaedmcaaaappmiahaaabaagmmaaa
obacabaabeihiaaaaamamablobabaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"sce_fp_rsx // 5 instructions using 2 registers
[Configuration]
24
ffffffff0000c0200003ffff000000000000840002000000
[Microcode]
80
be001702c8011c9dc8000001c8003fe10e800240fe001c9dc8000001c8000001
9e021700c8011c9dc8000001c8003fe10e800240c8041c9dc9003001c8000001
10810140c8041c9dc8000001c8000001
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 7 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjhfhafjjnaalbeceabobhppjddgpebdoabaaaaaapiabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaabaaaaeaaaaaaaeiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [unity_Lightmap] 2D
"agal_ps
c0 8.0 0.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v1, s1 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c0.x
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 7 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedgpjknelcilakdmlmokglemddllgfnidgabaaaaaanmacaaaaaeaaaaaa
daaaaaaabaabaaaadiacaaaakiacaaaaebgpgodjniaaaaaaniaaaaaaaaacpppp
kmaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkaabaaaaacaaaaadiaaaaabllaecaaaaadaaaacpiaaaaaoeiaabaioeka
ecaaaaadabaacpiaaaaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaaaaka
afaaaaadaaaachiaaaaaoeiaaaaappiaafaaaaadabaachiaaaaaoeiaabaaoeia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefccaabaaaaeaaaaaaaeiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaabaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
		Blend SrcAlpha One
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 54 to 62
//   d3d9 - ALU: 34 to 42
//   d3d11 - ALU: 16 to 29, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 16 to 29, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_Time]
Vector 14 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 15 [unity_Scale]
Matrix 9 [_LightMatrix0]
Float 16 [_RotationSpeed]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 61 ALU
PARAM c[22] = { { 0.5, 24.980801, -24.980801, 0.15915491 },
		state.matrix.mvp,
		program.local[5..17],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75, 0.25, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[13];
MUL R0.x, R0, c[16];
MUL R0.x, R0, c[0].w;
FRC R1.w, R0.x;
ADD R0.y, R0.x, -c[21].z;
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[18];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].yzyw;
ADD R0.xyz, -R1.w, c[18];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].yzyw;
ADD R1.xyz, R1, c[19].xyxw;
MAD R1.xyz, R1, R0, c[19].zwzw;
MAD R1.xyz, R1, R0, c[20].xyxw;
MAD R1.xyz, R1, R0, c[20].zwzw;
ADD R3.xyz, R3, c[19].xyxw;
MAD R3.xyz, R3, R2, c[19].zwzw;
MAD R3.xyz, R3, R2, c[20].xyxw;
MAD R1.xyz, R1, R0, c[18].wzww;
MAD R3.xyz, R3, R2, c[20].zwzw;
SLT R4.x, R1.w, c[21].z;
SGE R4.yz, R1.w, c[21].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[18].wzww;
DP3 R4.x, R1, -R0;
MAD R1.xyz, R3, R2, c[18].wzww;
SLT R0.x, R0.w, c[21].z;
SGE R0.yz, R0.w, c[21].xxyw;
DP3 R2.y, R0, c[18].wzww;
MOV R2.xz, R0;
DP3 R0.x, R1, -R2;
MOV R4.y, -R0.x;
MOV R0.y, R4.x;
MAD R0.xy, R0, c[0].x, c[0].x;
MUL R0.zw, R0.xyxy, c[21].w;
MAD R1.xy, R4, c[0].x, c[0].x;
MUL R0.xy, R1, c[21].w;
ADD R1.xy, R0.zwzw, -c[18].z;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R1.xy, R0.w, R1;
ADD R0.xy, R0, -c[18].z;
MAD R0.xy, R0.z, R0, R1;
MUL R1.xyz, vertex.normal, c[15].w;
ADD R0.xy, R0, c[0].x;
MAD result.texcoord[0].xy, R0, c[17], c[17].zwzw;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[3].z, R0, c[11];
DP4 result.texcoord[3].y, R0, c[10];
DP4 result.texcoord[3].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[14];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 61 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 14 [unity_Scale]
Matrix 8 [_LightMatrix0]
Float 15 [_RotationSpeed]
Vector 16 [_MainTex_ST]
"vs_2_0
; 41 ALU
def c17, -0.50000000, 0.15915491, 0.50000000, 0
def c18, 6.28318501, -3.14159298, 2.00000000, -1.00000000
def c19, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c20, -0.02083333, -0.12500000, 1.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c15
mul r0.x, c12, r0
mad r0.x, r0, c17.y, c17.z
frc r0.x, r0
mad r1.x, r0, c18, c18.y
sincos r0.xy, r1.x, c19.xyzw, c20.xyzw
mad r0.zw, r0.xyyx, c17.z, c17.z
mad r1.xy, r0.zwzw, c18.z, c18.w
add r0.zw, v3.xyxy, c17.x
mul r1.xy, r0.w, r1
mov r0.y, -r0
mad r0.xy, r0, c17.z, c17.z
mad r0.xy, r0, c18.z, c18.w
mad r0.xy, r0.z, r0, r1
mul r1.xyz, v2, c14.w
add r0.xy, r0, c17.z
mad oT0.xy, r0, c16, c16.zwzw
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT3.z, r0, c10
dp4 oT3.y, r0, c9
dp4 oT3.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
add oT2.xyz, -r0, c13
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "xbox360 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 11 [_LightMatrix0] 4
Vector 16 [_MainTex_ST]
Matrix 6 [_Object2World] 4
Float 15 [_RotationSpeed]
Vector 0 [_Time]
Vector 1 [_WorldSpaceLightPos0]
Matrix 2 [glstate_matrix_mvp] 4
Vector 10 [unity_Scale]
// Shader Timing Estimate, in Cycles/64 vertex vector:
// ALU: 32.00 (24 instructions), vertex: 32, texture: 0,
//   sequencer: 16,  5 GPRs, 31 threads,
// Performance (if enough threads): ~32 cycles per vector
// * Vertex cycle estimates are assuming 3 vfetch_minis for every vfetch_full,
//     with <= 32 bytes per vfetch_full group.

"vs_360
backbbabaaaaacbmaaaaabmaaaaaaaaaaaaaaaceaaaaabkaaaaaabmiaaaaaaaa
aaaaaaaaaaaaabhiaaaaaabmaaaaabgjpppoadaaaaaaaaaiaaaaaabmaaaaaaaa
aaaaabgcaaaaaalmaaacaaalaaaeaaaaaaaaaammaaaaaaaaaaaaaanmaaacaaba
aaabaaaaaaaaaaoiaaaaaaaaaaaaaapiaaacaaagaaaeaaaaaaaaaammaaaaaaaa
aaaaabagaaacaaapaaabaaaaaaaaabbiaaaaaaaaaaaaabciaaacaaaaaaabaaaa
aaaaaaoiaaaaaaaaaaaaabcoaaacaaabaaabaaaaaaaaaaoiaaaaaaaaaaaaabed
aaacaaacaaaeaaaaaaaaaammaaaaaaaaaaaaabfgaaacaaakaaabaaaaaaaaaaoi
aaaaaaaafpemgjghgiheengbhehcgjhidaaaklklaaadaaadaaaeaaaeaaabaaaa
aaaaaaaafpengbgjgofegfhifpfdfeaaaaabaaadaaabaaaeaaabaaaaaaaaaaaa
fpepgcgkgfgdhedcfhgphcgmgeaafpfcgphegbhegjgpgofdhagfgfgeaaklklkl
aaaaaaadaaabaaabaaabaaaaaaaaaaaafpfegjgngfaafpfhgphcgmgefdhagbgd
gfemgjghgihefagphddaaaghgmhdhegbhegffpgngbhehcgjhifpgnhghaaahfgo
gjhehjfpfdgdgbgmgfaahghdfpddfpdaaadccodacodcdadddfddcodaaaklklkl
aaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaabeaapmaabaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaeaaaaaabiaaadbaaaeaaaaaaaaaaaaaaaaaaaacmie
aaaaaaabaaaaaaadaaaaaaaeaaaaacjaaabaaaaeaaaadaafaacafaagaaaadafa
aaabhbfbaaachcfcaaadhdfdaaaababoaaaababeaaaababdaaaabablaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaamaejapnl
eamjapnlaaaaaaaaaaaaaaaadpaaaaaalpaaaaaalpiaaaaadoccpjidhabfdaae
aaaabcaamcaaaaaaaaaaeaahaaaabcaameaaaaaaaaaagaalgabbbcaabcaaaaaa
aaaagabhcabnbcaaccaaaaaaafpieaaaaaaaagiiaaaaaaaaafpiaaaaaaaaaeeh
aaaaaaaaafpibaaaaaaaaoehaaaaaaaamiapaaacaabliiaakbaeafaamiapaaac
aamgiiaaklaeaeacmiapaaacaalbdejeklaeadacmiapiadoaagmaadeklaeacac
beanaaaaaadcblgmibaaakapamcpaaacaablaablibaeajppmiapaaacaamgaaaa
klaeaiackibhabadaablleebibaaaiaamiahaaadaagmlemaklaaahadmiapaaac
aalbaaaaklaeahacmiadaaaaaamelaaakaabppaamiapaaacaagmffffklaeagac
miahiaacaelpmaaakaacabaamiahiaabaamgmaleklaaagadcmehaaadaamglegm
kbacaoaamiaeaaaaaamglbgmilaapopomiahaaadaalbmaleklacanadmabeabab
aclbgmmgkaabppaameciababaagmmgmgkbabppaamiahaaacaagmleleklacamad
miahiaadaablmaleklacalacmiadaaaaaalblagmmlaaabppmiadaaaaaabkmfla
olababaamiadiaaaaalalabkilaababaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "POINT" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_Time]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Vector 465 [unity_Scale]
Matrix 264 [_LightMatrix0]
Float 464 [_RotationSpeed]
Vector 463 [_MainTex_ST]
"sce_vp_rsx // 29 instructions using 3 registers
[Configuration]
8
0000001d01050300
[Defaults]
1
462 3
3f000000400000003f800000
[Microcode]
464
00009c6c009d120c013fc0c36041dffc00011c6c00dce8800186c08200419ffc
401f9c6c01d0300d8106c0c360403f80401f9c6c01d0200d8106c0c360405f80
401f9c6c01d0100d8106c0c360409f80401f9c6c01d0000d8106c0c360411f80
00001c6c01d0700d8106c0c360403ffc00009c6c005d30000186c08360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc401f9c6c0150600c028600c360405fa0
401f9c6c0150500c028600c360409fa0401f9c6c0150400c028600c360411fa0
401f9c6c00dd200c0186c0a30021dfa400009c6c009d007f828000c360409ffc
401f9c6c79d0a00d8086c0caa0b040a8401f9c6c81d0900d8086c0caa0a480a8
00009c6c004000800286c08360403ffc00009c6c004000550286c08360409ffc
00009c6c011ce008028000c000619ffc00009c6c011ce055828000c000607ffc
00009c6c011ce008029540f540619ffc00009c6c011ce055829540f540607ffc
00009c6c0080002a8484014360419ffc00009c6c0100000004ae814200a19ffc
00009c6c00dce0000186c08200a19ffc401f9c6c01d0800d8086c0c360411fa8
401f9c6c011cf008028400d740619f9d
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 6 vars
Matrix 48 [_LightMatrix0] 4
Float 112 [_RotationSpeed]
Vector 128 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 32 instructions, 3 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedggohdbpeejhhniahfadojalngfpaphekabaaaaaaoiagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcemafaaaaeaaaabaa
fdabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
akiacaaaabaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaap
hcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaa
egbabaaaadaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaacaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaa
acaaaaaabgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaadaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_10)).w) * 2.0));
  c_11.w = tmpvar_4;
  c_1.xyz = c_11.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_10)).w) * 2.0));
  c_11.w = tmpvar_4;
  c_1.xyz = c_11.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 14 [unity_Scale]
Matrix 8 [_LightMatrix0]
Float 15 [_RotationSpeed]
Vector 16 [_MainTex_ST]
"agal_vs
c17 -0.5 0.159155 0.5 0.0
c18 6.283185 -3.141593 2.0 -1.0
c19 -0.000002 -0.000022 0.002604 0.00026
c20 -0.020833 -0.125 1.0 0.5
[bc]
aaaaaaaaaaaaabacapaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c15
adaaaaaaaaaaabacamaaaaoeabaaaaaaaaaaaaaaacaaaaaa mul r0.x, c12, r0.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaabbaaaaffabaaaaaa mul r0.x, r0.x, c17.y
abaaaaaaaaaaabacaaaaaaaaacaaaaaabbaaaakkabaaaaaa add r0.x, r0.x, c17.z
aiaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa frc r0.x, r0.x
adaaaaaaabaaabacaaaaaaaaacaaaaaabcaaaaoeabaaaaaa mul r1.x, r0.x, c18
abaaaaaaabaaabacabaaaaaaacaaaaaabcaaaaffabaaaaaa add r1.x, r1.x, c18.y
apaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sin r0.x, r1.x
baaaaaaaaaaaacacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa cos r0.y, r1.x
adaaaaaaaaaaamacaaaaaabaacaaaaaabbaaaakkabaaaaaa mul r0.zw, r0.xxyx, c17.z
abaaaaaaaaaaamacaaaaaaopacaaaaaabbaaaakkabaaaaaa add r0.zw, r0.wwzw, c17.z
adaaaaaaabaaadacaaaaaapoacaaaaaabcaaaakkabaaaaaa mul r1.xy, r0.zwww, c18.z
abaaaaaaabaaadacabaaaafeacaaaaaabcaaaappabaaaaaa add r1.xy, r1.xyyy, c18.w
abaaaaaaaaaaamacadaaaaeeaaaaaaaabbaaaaaaabaaaaaa add r0.zw, a3.xyxy, c17.x
adaaaaaaabaaadacaaaaaappacaaaaaaabaaaafeacaaaaaa mul r1.xy, r0.w, r1.xyyy
bfaaaaaaaaaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r0.y
adaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa mul r0.xy, r0.xyyy, c17.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa add r0.xy, r0.xyyy, c17.z
adaaaaaaaaaaadacaaaaaafeacaaaaaabcaaaakkabaaaaaa mul r0.xy, r0.xyyy, c18.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabcaaaappabaaaaaa add r0.xy, r0.xyyy, c18.w
adaaaaaaaaaaadacaaaaaakkacaaaaaaaaaaaafeacaaaaaa mul r0.xy, r0.z, r0.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaafeacaaaaaa add r0.xy, r0.xyyy, r1.xyyy
adaaaaaaabaaahacabaaaaoeaaaaaaaaaoaaaappabaaaaaa mul r1.xyz, a1, c14.w
abaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa add r0.xy, r0.xyyy, c17.z
adaaaaaaacaaadacaaaaaafeacaaaaaabaaaaaoeabaaaaaa mul r2.xy, r0.xyyy, c16
abaaaaaaaaaaadaeacaaaafeacaaaaaabaaaaaooabaaaaaa add v0.xy, r2.xyyy, c16.zwzw
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaadaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v3.z, r0, c10
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v3.y, r0, c9
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v3.x, r0, c8
bcaaaaaaabaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r1.xyzz, c6
bcaaaaaaabaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r1.xyzz, c5
bcaaaaaaabaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r1.xyzz, c4
bfaaaaaaacaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r0.xyzz
abaaaaaaacaaahaeacaaaakeacaaaaaaanaaaaoeabaaaaaa add v2.xyz, r2.xyzz, c13
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 6 vars
Matrix 48 [_LightMatrix0] 4
Float 112 [_RotationSpeed]
Vector 128 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 32 instructions, 3 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedlikcglhmadgelpgobekdmdbglgnlgpmjabaaaaaamaakaaaaaeaaaaaa
daaaaaaaaeaeaaaafiajaaaacaakaaaaebgpgodjmmadaaaammadaaaaaaacpopp
fmadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
agaaabaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaacaaaaaaabaaaiaaaaaaaaaa
adaaaaaaaeaaajaaaaaaaaaaadaaamaaaeaaanaaaaaaaaaaadaabeaaabaabbaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbcaaapkaaaaaaalpidpjccdoaaaaaadp
aaaaiadofbaaaaafbdaaapkanlapmjeanlapejmagdibihlekblfmpdhfbaaaaaf
beaaapkalkajlglkkekkckdnaaaaiadpaaaaaamabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaabaaaaacaaaaabia
afaaaakaafaaaaadaaaaabiaaaaaaaiaahaaaakaaeaaaaaeaaaaapiaaaaaaaia
bcaaffkabcaalokabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeia
bdaaaakabdaaffkaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeabaaapia
aaaaoliabdaakkkabdaappkaaeaaaaaeabaaapiaaaaaoliaabaaoeiabeaaaaka
aeaaaaaeabaaapiaaaaaoliaabaaoeiabeaaffkaaeaaaaaeabaaapiaaaaaolia
abaaoeiabcaaaakaaeaaaaaeaaaaapiaaaaaoeiaabaaoeiabeaakkkaaeaaaaae
aaaaapiaaaaaoeiabcaaikkabcaakkkaaeaaaaaeaaaaapiaaaaaoeiabeaappkb
beaakkkbacaaaaadabaaapiaadaaeejabcaaaakaafaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaadiaaaaaoniaaaaaoiiaacaaaaadaaaaadiaaaaaoeia
bcaakkkaaeaaaaaeaaaaadoaaaaaoeiaagaaoekaagaaookaafaaaaadaaaaahia
acaaoejabbaappkaafaaaaadabaaahiaaaaaffiaaoaaoekaaeaaaaaeaaaaalia
anaakekaaaaaaaiaabaakeiaaeaaaaaeabaaahoaapaaoekaaaaakkiaaaaapeia
afaaaaadaaaaahiaaaaaffjaaoaaoekaaeaaaaaeaaaaahiaanaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahia
baaaoekaaaaappjaaaaaoeiaacaaaaadacaaahoaaaaaoeibaiaaoekaafaaaaad
aaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoeka
aaaappjaaaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahia
abaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeia
aeaaaaaeadaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
akaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
alaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefcemafaaaaeaaaabaafdabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajbcaabaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaaakiacaaaabaaaaaaaaaaaaaaenaaaaah
bcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaaaaaaaaaadgaaaaafgcaabaaa
abaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaaadaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaacaaaaaaegaabaaaabaaaaaa
igaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaabgafbaaaabaaaaaaegaabaaa
aaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegaabaaaaaaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
};
#line 418
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
#line 399
uniform highp float _RotationSpeed;
#line 412
#line 427
uniform highp vec4 _MainTex_ST;
#line 77
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return (_WorldSpaceLightPos0.xyz - worldPos);
}
#line 400
void vert( inout appdata_full v ) {
    v.texcoord.xy -= 0.5;
    #line 403
    highp float s = float( sin((_RotationSpeed * _Time)));
    highp float c = float( cos((_RotationSpeed * _Time)));
    highp mat2 rotationMatrix = mat2( c, s, (-s), c);
    rotationMatrix *= 0.5;
    #line 407
    rotationMatrix += 0.5;
    rotationMatrix = ((rotationMatrix * 2.0) - 1.0);
    v.texcoord.xy = (v.texcoord.xy * rotationMatrix);
    v.texcoord.xy += 0.5;
}
#line 428
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 431
    vert( v);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 435
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 439
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
};
#line 418
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
#line 399
uniform highp float _RotationSpeed;
#line 412
#line 427
uniform highp vec4 _MainTex_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    mediump vec4 c = texture( _MainTex, IN.uv_MainTex);
    o.Albedo = c.xyz;
    #line 416
    o.Alpha = c.w;
}
#line 441
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 443
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 447
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 451
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingLambert( o, lightDir, (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * 1.0));
    #line 455
    c.w = o.Alpha;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_Time]
Vector 10 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 11 [unity_Scale]
Float 12 [_RotationSpeed]
Vector 13 [_MainTex_ST]
"!!ARBvp1.0
# 54 ALU
PARAM c[18] = { { 0.5, 24.980801, -24.980801, 0.15915491 },
		state.matrix.mvp,
		program.local[5..13],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75, 0.25, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[9];
MUL R0.x, R0, c[12];
MUL R0.x, R0, c[0].w;
FRC R1.w, R0.x;
ADD R0.y, R0.x, -c[17].z;
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[14];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].yzyw;
ADD R0.xyz, -R1.w, c[14];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].yzyw;
ADD R1.xyz, R1, c[15].xyxw;
MAD R1.xyz, R1, R0, c[15].zwzw;
MAD R1.xyz, R1, R0, c[16].xyxw;
MAD R1.xyz, R1, R0, c[16].zwzw;
ADD R3.xyz, R3, c[15].xyxw;
MAD R3.xyz, R3, R2, c[15].zwzw;
MAD R3.xyz, R3, R2, c[16].xyxw;
MAD R1.xyz, R1, R0, c[14].wzww;
MAD R3.xyz, R3, R2, c[16].zwzw;
SLT R4.x, R1.w, c[17].z;
SGE R4.yz, R1.w, c[17].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[14].wzww;
DP3 R4.x, R1, -R0;
MAD R1.xyz, R3, R2, c[14].wzww;
SLT R0.x, R0.w, c[17].z;
SGE R0.yz, R0.w, c[17].xxyw;
DP3 R2.y, R0, c[14].wzww;
MOV R2.xz, R0;
DP3 R0.x, R1, -R2;
MOV R4.y, -R0.x;
MOV R0.y, R4.x;
MAD R0.xy, R0, c[0].x, c[0].x;
MUL R0.zw, R0.xyxy, c[17].w;
MAD R1.xy, R4, c[0].x, c[0].x;
MUL R0.xy, R1, c[17].w;
ADD R1.xy, R0.zwzw, -c[14].z;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R1.xy, R0.w, R1;
ADD R0.xy, R0, -c[14].z;
MAD R0.xy, R0.z, R0, R1;
MUL R1.xyz, vertex.normal, c[11].w;
ADD R0.xy, R0, c[0].x;
MAD result.texcoord[0].xy, R0, c[13], c[13].zwzw;
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
MOV result.texcoord[2].xyz, c[10];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 54 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 10 [unity_Scale]
Float 11 [_RotationSpeed]
Vector 12 [_MainTex_ST]
"vs_2_0
; 34 ALU
def c13, -0.50000000, 0.15915491, 0.50000000, 0
def c14, 6.28318501, -3.14159298, 2.00000000, -1.00000000
def c15, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c16, -0.02083333, -0.12500000, 1.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c11
mul r0.x, c8, r0
mad r0.x, r0, c13.y, c13.z
frc r0.x, r0
mad r1.x, r0, c14, c14.y
sincos r0.xy, r1.x, c15.xyzw, c16.xyzw
mad r0.zw, r0.xyyx, c13.z, c13.z
mad r1.xy, r0.zwzw, c14.z, c14.w
add r0.zw, v3.xyxy, c13.x
mov r0.y, -r0
mad r0.xy, r0, c13.z, c13.z
mul r1.xy, r0.w, r1
mad r0.xy, r0, c14.z, c14.w
mad r0.xy, r0.z, r0, r1
mul r1.xyz, v2, c10.w
add r0.xy, r0, c13.z
mad oT0.xy, r0, c12, c12.zwzw
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
mov oT2.xyz, c9
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 11 [_MainTex_ST]
Matrix 6 [_Object2World] 3
Float 10 [_RotationSpeed]
Vector 0 [_Time]
Vector 1 [_WorldSpaceLightPos0]
Matrix 2 [glstate_matrix_mvp] 4
Vector 9 [unity_Scale]
// Shader Timing Estimate, in Cycles/64 vertex vector:
// ALU: 24.00 (18 instructions), vertex: 32, texture: 0,
//   sequencer: 14,  4 GPRs, 31 threads,
// Performance (if enough threads): ~32 cycles per vector
// * Vertex cycle estimates are assuming 3 vfetch_minis for every vfetch_full,
//     with <= 32 bytes per vfetch_full group.

"vs_360
backbbabaaaaabpaaaaaabhiaaaaaaaaaaaaaaceaaaaabhmaaaaabkeaaaaaaaa
aaaaaaaaaaaaabfeaaaaaabmaaaaabefpppoadaaaaaaaaahaaaaaabmaaaaaaaa
aaaaabdoaaaaaakiaaacaaalaaabaaaaaaaaaaleaaaaaaaaaaaaaameaaacaaag
aaadaaaaaaaaaaneaaaaaaaaaaaaaaoeaaacaaakaaabaaaaaaaaaapeaaaaaaaa
aaaaabaeaaacaaaaaaabaaaaaaaaaaleaaaaaaaaaaaaabakaaacaaabaaabaaaa
aaaaaaleaaaaaaaaaaaaabbpaaacaaacaaaeaaaaaaaaaaneaaaaaaaaaaaaabdc
aaacaaajaaabaaaaaaaaaaleaaaaaaaafpengbgjgofegfhifpfdfeaaaaabaaad
aaabaaaeaaabaaaaaaaaaaaafpepgcgkgfgdhedcfhgphcgmgeaaklklaaadaaad
aaaeaaaeaaabaaaaaaaaaaaafpfcgphegbhegjgpgofdhagfgfgeaaklaaaaaaad
aaabaaabaaabaaaaaaaaaaaafpfegjgngfaafpfhgphcgmgefdhagbgdgfemgjgh
gihefagphddaaaghgmhdhegbhegffpgngbhehcgjhifpgnhghaaahfgogjhehjfp
fdgdgbgmgfaahghdfpddfpdaaadccodacodcdadddfddcodaaaklklklaaaaaaaa
aaaaaaabaaaaaaaaaaaaaaaaaaaaaabeaapmaabaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaabdiaacbaaadaaaaaaaaaaaaaaaaaaaacagdaaaaaaab
aaaaaaadaaaaaaadaaaaacjaaabaaaaeaaaadaafaacafaagaaaadafaaaabhbfb
aaachcfcaaaababiaaaababcaaaababbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaamaejapnleamjapnlaaaaaaaaaaaaaaaa
dpaaaaaalpaaaaaalpiaaaaadoccpjidhabfdaaeaaaabcaamcaaaaaaaaaaeaah
aaaabcaameaaaaaaaaaagaalgabbbcaabcaaaaaaaaaacabhaaaaccaaaaaaaaaa
afpidaaaaaaaagiiaaaaaaaaafpicaaaaaaaaoiiaaaaaaaaafpibaaaaaaaaoeh
aaaaaaaamiapaaaaaabliiaakbadafaamiapaaaaaamgiiaakladaeaamiapaaaa
aalbdejekladadaamiapiadoaagmaadekladacaamiacaaaaaagmblaacbakppaa
mianaaaaaaefblaakbacajaakibhabacaamgleebibaaaiaamiahaaacaagmlema
klaaahacmiadaaaaaamelaaakaabppaacmeaaaaaaaaaaagmocaaaaaamiahiaac
aamamaaaccababaamiahiaabaablmaleklaaagacmiaeaaaaaamglbgmilaapopo
mabeababaclbgmmgkaabppaameciababaagmmgmgkbabppaamiadaaaaaalblagm
mlaaabppmiadaaaaaabkmflaolababaamiadiaaaaalalabkilaaalalaaaaaaaa
aaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_Time]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Vector 465 [unity_Scale]
Float 464 [_RotationSpeed]
Vector 463 [_MainTex_ST]
"sce_vp_rsx // 22 instructions using 3 registers
[Configuration]
8
0000001601050300
[Defaults]
1
462 3
3f000000400000003f800000
[Microcode]
352
401f9c6c005d200c0186c0836041dfa400009c6c009d120c013fc0c36041dffc
00011c6c00dce8800186c08200419ffc401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c005d30000186c08360411ffc
00001c6c009d0000008000c360409ffc401f9c6c7950600c028600caa0304020
401f9c6c8150500c028600caa024802000001c6c004000800086c08360403ffc
00001c6c004000550086c08360409ffc00001c6c011ce008008000c000619ffc
00001c6c011ce055808000c000607ffc00001c6c011ce008009540f540619ffc
00001c6c011ce055809540f540607ffc00001c6c0080002a8484004360419ffc
00001c6c0100000004ae804200219ffc00001c6c00dce0000186c08200219ffc
401f9c6c0150400c028600c360411fa0401f9c6c011cf008008400d740619f9d
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 80 // 80 used size, 5 vars
Float 48 [_RotationSpeed]
Vector 64 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 20 instructions, 3 temp regs, 0 temp arrays:
// ALU 16 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbekhmlephofffefpcdgbkhieoejkcofiabaaaaaapaaeaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
gmadaaaaeaaaabaanlaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaaakiacaaa
abaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaa
aaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaa
adaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaa
acaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaa
bgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaa
egiccaaaacaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = c_9.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = c_9.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_Time]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 10 [unity_Scale]
Float 11 [_RotationSpeed]
Vector 12 [_MainTex_ST]
"agal_vs
c13 -0.5 0.159155 0.5 0.0
c14 6.283185 -3.141593 2.0 -1.0
c15 -0.000002 -0.000022 0.002604 0.00026
c16 -0.020833 -0.125 1.0 0.5
[bc]
aaaaaaaaaaaaabacalaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c11
adaaaaaaaaaaabacaiaaaaoeabaaaaaaaaaaaaaaacaaaaaa mul r0.x, c8, r0.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaaanaaaaffabaaaaaa mul r0.x, r0.x, c13.y
abaaaaaaaaaaabacaaaaaaaaacaaaaaaanaaaakkabaaaaaa add r0.x, r0.x, c13.z
aiaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa frc r0.x, r0.x
adaaaaaaabaaabacaaaaaaaaacaaaaaaaoaaaaoeabaaaaaa mul r1.x, r0.x, c14
abaaaaaaabaaabacabaaaaaaacaaaaaaaoaaaaffabaaaaaa add r1.x, r1.x, c14.y
apaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sin r0.x, r1.x
baaaaaaaaaaaacacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa cos r0.y, r1.x
adaaaaaaaaaaamacaaaaaabaacaaaaaaanaaaakkabaaaaaa mul r0.zw, r0.xxyx, c13.z
abaaaaaaaaaaamacaaaaaaopacaaaaaaanaaaakkabaaaaaa add r0.zw, r0.wwzw, c13.z
adaaaaaaabaaadacaaaaaapoacaaaaaaaoaaaakkabaaaaaa mul r1.xy, r0.zwww, c14.z
abaaaaaaabaaadacabaaaafeacaaaaaaaoaaaappabaaaaaa add r1.xy, r1.xyyy, c14.w
abaaaaaaaaaaamacadaaaaeeaaaaaaaaanaaaaaaabaaaaaa add r0.zw, a3.xyxy, c13.x
bfaaaaaaaaaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r0.y
adaaaaaaaaaaadacaaaaaafeacaaaaaaanaaaakkabaaaaaa mul r0.xy, r0.xyyy, c13.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaanaaaakkabaaaaaa add r0.xy, r0.xyyy, c13.z
adaaaaaaabaaadacaaaaaappacaaaaaaabaaaafeacaaaaaa mul r1.xy, r0.w, r1.xyyy
adaaaaaaaaaaadacaaaaaafeacaaaaaaaoaaaakkabaaaaaa mul r0.xy, r0.xyyy, c14.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaaoaaaappabaaaaaa add r0.xy, r0.xyyy, c14.w
adaaaaaaaaaaadacaaaaaakkacaaaaaaaaaaaafeacaaaaaa mul r0.xy, r0.z, r0.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaafeacaaaaaa add r0.xy, r0.xyyy, r1.xyyy
adaaaaaaabaaahacabaaaaoeaaaaaaaaakaaaappabaaaaaa mul r1.xyz, a1, c10.w
abaaaaaaaaaaadacaaaaaafeacaaaaaaanaaaakkabaaaaaa add r0.xy, r0.xyyy, c13.z
adaaaaaaaaaaadacaaaaaafeacaaaaaaamaaaaoeabaaaaaa mul r0.xy, r0.xyyy, c12
abaaaaaaaaaaadaeaaaaaafeacaaaaaaamaaaaooabaaaaaa add v0.xy, r0.xyyy, c12.zwzw
bcaaaaaaabaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r1.xyzz, c6
bcaaaaaaabaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r1.xyzz, c5
bcaaaaaaabaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r1.xyzz, c4
aaaaaaaaacaaahaeajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.xyz, c9
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 80 // 80 used size, 5 vars
Float 48 [_RotationSpeed]
Vector 64 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 20 instructions, 3 temp regs, 0 temp arrays:
// ALU 16 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecednjgkpeenmlmcdkbfhgookiklnglpdghkabaaaaaaoaahaaaaaeaaaaaa
daaaaaaabmadaaaajaagaaaafiahaaaaebgpgodjoeacaaaaoeacaaaaaaacpopp
heacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaacaaaaaaabaaaeaaaaaaaaaa
adaaaaaaaeaaafaaaaaaaaaaadaaamaaadaaajaaaaaaaaaaadaabeaaabaaamaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafanaaapkaaaaaaalpidpjccdoaaaaaadp
aaaaiadofbaaaaafaoaaapkanlapmjeanlapejmagdibihlekblfmpdhfbaaaaaf
apaaapkalkajlglkkekkckdnaaaaiadpaaaaaamabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaabaaaaacaaaaabia
abaaaakaafaaaaadaaaaabiaaaaaaaiaadaaaakaaeaaaaaeaaaaapiaaaaaaaia
anaaffkaanaalokabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeia
aoaaaakaaoaaffkaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeabaaapia
aaaaoliaaoaakkkaaoaappkaaeaaaaaeabaaapiaaaaaoliaabaaoeiaapaaaaka
aeaaaaaeabaaapiaaaaaoliaabaaoeiaapaaffkaaeaaaaaeabaaapiaaaaaolia
abaaoeiaanaaaakaaeaaaaaeaaaaapiaaaaaoeiaabaaoeiaapaakkkaaeaaaaae
aaaaapiaaaaaoeiaanaaikkaanaakkkaaeaaaaaeaaaaapiaaaaaoeiaapaappkb
apaakkkbacaaaaadabaaapiaadaaeejaanaaaakaafaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaadiaaaaaoniaaaaaoiiaacaaaaadaaaaadiaaaaaoeia
anaakkkaaeaaaaaeaaaaadoaaaaaoeiaacaaoekaacaaookaafaaaaadaaaaahia
acaaoejaamaappkaafaaaaadabaaahiaaaaaffiaakaaoekaaeaaaaaeaaaaalia
ajaakekaaaaaaaiaabaakeiaaeaaaaaeabaaahoaalaaoekaaaaakkiaaaaapeia
afaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacacaaahoaaeaaoekappppaaaafdeieefc
gmadaaaaeaaaabaanlaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaaakiacaaa
abaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaa
aaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaa
adaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaa
acaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaa
bgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaa
egiccaaaacaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 424
uniform highp vec4 _MainTex_ST;
#line 437
#line 77
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return _WorldSpaceLightPos0.xyz;
}
#line 398
void vert( inout appdata_full v ) {
    v.texcoord.xy -= 0.5;
    #line 401
    highp float s = float( sin((_RotationSpeed * _Time)));
    highp float c = float( cos((_RotationSpeed * _Time)));
    highp mat2 rotationMatrix = mat2( c, s, (-s), c);
    rotationMatrix *= 0.5;
    #line 405
    rotationMatrix += 0.5;
    rotationMatrix = ((rotationMatrix * 2.0) - 1.0);
    v.texcoord.xy = (v.texcoord.xy * rotationMatrix);
    v.texcoord.xy += 0.5;
}
#line 425
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 428
    vert( v);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 432
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 392
struct Input {
    highp vec2 uv_MainTex;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
#line 397
uniform highp float _RotationSpeed;
#line 410
#line 424
uniform highp vec4 _MainTex_ST;
#line 437
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 410
void surf( in Input IN, inout SurfaceOutput o ) {
    mediump vec4 c = texture( _MainTex, IN.uv_MainTex);
    o.Albedo = c.xyz;
    #line 414
    o.Alpha = c.w;
}
#line 437
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 441
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 445
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    #line 449
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingLambert( o, lightDir, 1.0);
    c.w = o.Alpha;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_Time]
Vector 14 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 15 [unity_Scale]
Matrix 9 [_LightMatrix0]
Float 16 [_RotationSpeed]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 62 ALU
PARAM c[22] = { { 0.5, 24.980801, -24.980801, 0.15915491 },
		state.matrix.mvp,
		program.local[5..17],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75, 0.25, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[13];
MUL R0.x, R0, c[16];
MUL R0.x, R0, c[0].w;
FRC R1.w, R0.x;
ADD R0.y, R0.x, -c[21].z;
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[18];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].yzyw;
ADD R0.xyz, -R1.w, c[18];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].yzyw;
ADD R1.xyz, R1, c[19].xyxw;
MAD R1.xyz, R1, R0, c[19].zwzw;
MAD R1.xyz, R1, R0, c[20].xyxw;
MAD R1.xyz, R1, R0, c[20].zwzw;
ADD R3.xyz, R3, c[19].xyxw;
MAD R3.xyz, R3, R2, c[19].zwzw;
MAD R3.xyz, R3, R2, c[20].xyxw;
MAD R1.xyz, R1, R0, c[18].wzww;
MAD R3.xyz, R3, R2, c[20].zwzw;
SLT R4.x, R1.w, c[21].z;
SGE R4.yz, R1.w, c[21].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[18].wzww;
DP3 R4.x, R1, -R0;
MAD R1.xyz, R3, R2, c[18].wzww;
SLT R0.x, R0.w, c[21].z;
SGE R0.yz, R0.w, c[21].xxyw;
DP3 R2.y, R0, c[18].wzww;
MOV R2.xz, R0;
DP3 R0.x, R1, -R2;
MOV R4.y, -R0.x;
MOV R0.y, R4.x;
MAD R0.xy, R0, c[0].x, c[0].x;
MUL R0.zw, R0.xyxy, c[21].w;
MAD R1.xy, R4, c[0].x, c[0].x;
MUL R0.xy, R1, c[21].w;
ADD R1.xy, R0.zwzw, -c[18].z;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R1.xy, R0.w, R1;
ADD R0.xy, R0, -c[18].z;
MAD R0.xy, R0.z, R0, R1;
MUL R1.xyz, vertex.normal, c[15].w;
ADD R0.xy, R0, c[0].x;
MAD result.texcoord[0].xy, R0, c[17], c[17].zwzw;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[3].w, R0, c[12];
DP4 result.texcoord[3].z, R0, c[11];
DP4 result.texcoord[3].y, R0, c[10];
DP4 result.texcoord[3].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[14];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 62 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 14 [unity_Scale]
Matrix 8 [_LightMatrix0]
Float 15 [_RotationSpeed]
Vector 16 [_MainTex_ST]
"vs_2_0
; 42 ALU
def c17, -0.50000000, 0.15915491, 0.50000000, 0
def c18, 6.28318501, -3.14159298, 2.00000000, -1.00000000
def c19, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c20, -0.02083333, -0.12500000, 1.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c15
mul r0.x, c12, r0
mad r0.x, r0, c17.y, c17.z
frc r0.x, r0
mad r1.x, r0, c18, c18.y
sincos r0.xy, r1.x, c19.xyzw, c20.xyzw
mad r0.zw, r0.xyyx, c17.z, c17.z
mad r1.xy, r0.zwzw, c18.z, c18.w
add r0.zw, v3.xyxy, c17.x
mul r1.xy, r0.w, r1
mov r0.y, -r0
mad r0.xy, r0, c17.z, c17.z
mad r0.xy, r0, c18.z, c18.w
mad r0.xy, r0.z, r0, r1
mul r1.xyz, v2, c14.w
add r0.xy, r0, c17.z
mad oT0.xy, r0, c16, c16.zwzw
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT3.w, r0, c11
dp4 oT3.z, r0, c10
dp4 oT3.y, r0, c9
dp4 oT3.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
add oT2.xyz, -r0, c13
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "xbox360 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 11 [_LightMatrix0] 4
Vector 16 [_MainTex_ST]
Matrix 6 [_Object2World] 4
Float 15 [_RotationSpeed]
Vector 0 [_Time]
Vector 1 [_WorldSpaceLightPos0]
Matrix 2 [glstate_matrix_mvp] 4
Vector 10 [unity_Scale]
// Shader Timing Estimate, in Cycles/64 vertex vector:
// ALU: 32.00 (24 instructions), vertex: 32, texture: 0,
//   sequencer: 16,  5 GPRs, 31 threads,
// Performance (if enough threads): ~32 cycles per vector
// * Vertex cycle estimates are assuming 3 vfetch_minis for every vfetch_full,
//     with <= 32 bytes per vfetch_full group.

"vs_360
backbbabaaaaacbmaaaaabmaaaaaaaaaaaaaaaceaaaaabkaaaaaabmiaaaaaaaa
aaaaaaaaaaaaabhiaaaaaabmaaaaabgjpppoadaaaaaaaaaiaaaaaabmaaaaaaaa
aaaaabgcaaaaaalmaaacaaalaaaeaaaaaaaaaammaaaaaaaaaaaaaanmaaacaaba
aaabaaaaaaaaaaoiaaaaaaaaaaaaaapiaaacaaagaaaeaaaaaaaaaammaaaaaaaa
aaaaabagaaacaaapaaabaaaaaaaaabbiaaaaaaaaaaaaabciaaacaaaaaaabaaaa
aaaaaaoiaaaaaaaaaaaaabcoaaacaaabaaabaaaaaaaaaaoiaaaaaaaaaaaaabed
aaacaaacaaaeaaaaaaaaaammaaaaaaaaaaaaabfgaaacaaakaaabaaaaaaaaaaoi
aaaaaaaafpemgjghgiheengbhehcgjhidaaaklklaaadaaadaaaeaaaeaaabaaaa
aaaaaaaafpengbgjgofegfhifpfdfeaaaaabaaadaaabaaaeaaabaaaaaaaaaaaa
fpepgcgkgfgdhedcfhgphcgmgeaafpfcgphegbhegjgpgofdhagfgfgeaaklklkl
aaaaaaadaaabaaabaaabaaaaaaaaaaaafpfegjgngfaafpfhgphcgmgefdhagbgd
gfemgjghgihefagphddaaaghgmhdhegbhegffpgngbhehcgjhifpgnhghaaahfgo
gjhehjfpfdgdgbgmgfaahghdfpddfpdaaadccodacodcdadddfddcodaaaklklkl
aaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaabeaapmaabaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaeaaaaaabiaaadbaaaeaaaaaaaaaaaaaaaaaaaadaie
aaaaaaabaaaaaaadaaaaaaaeaaaaacjaaabaaaaeaaaadaafaacafaagaaaadafa
aaabhbfbaaachcfcaaadpdfdaaaababoaaaababeaaaababdaaaabablaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaamaejapnl
eamjapnlaaaaaaaaaaaaaaaalpaaaaaadpaaaaaalpiaaaaadoccpjidhabfdaae
aaaabcaamcaaaaaaaaaaeaahaaaabcaameaaaaaaaaaagaalgabbbcaabcaaaaaa
aaaagabhcabnbcaaccaaaaaaafpieaaaaaaaagiiaaaaaaaaafpiaaaaaaaaaeeh
aaaaaaaaafpibaaaaaaaapmiaaaaaaaamiapaaacaabliiaakbaeafaamiapaaac
aamgiiaaklaeaeacmiapaaacaalbdejeklaeadacmiapiadoaagmaadeklaeacac
beanaaaaaadcblgmibaaakapamcpaaacaablaablibaeajppmiapaaadaamgaaaa
klaeaiackiehabacaablleebibaaaiaamiahaaacaagmlemaklaaahacmiapaaad
aalbaaaaklaeahadmiadaaaaaamflaaakaabppaamiapaaadaagmaaaaklaeagad
miahiaacaemamaaakaadabaamiahiaabaamgmaleklaaagaccmepaaacaabliilb
kbadaoaamiaeaaaaaamglbgmilaapopomiapaaacaamgiiaakladanacmabeabab
acgmlbmgkaabppaameciababaagmmgmgkbabppaamiapaaacaalbdejekladamac
miapiaadaagmaadekladalacmiadaaaaaagmlalbmlaaabppmiadaaaaaabkmfla
olababaamiadiaaaaalalabkilaababaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "SPOT" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_Time]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Vector 465 [unity_Scale]
Matrix 264 [_LightMatrix0]
Float 464 [_RotationSpeed]
Vector 463 [_MainTex_ST]
"sce_vp_rsx // 30 instructions using 3 registers
[Configuration]
8
0000001e01050300
[Defaults]
1
462 3
3f000000400000003f800000
[Microcode]
480
00009c6c009d120c013fc0c36041dffc00011c6c00dce8800186c08200419ffc
401f9c6c01d0300d8106c0c360403f80401f9c6c01d0200d8106c0c360405f80
401f9c6c01d0100d8106c0c360409f80401f9c6c01d0000d8106c0c360411f80
00001c6c01d0700d8106c0c360403ffc00009c6c005d30000186c08360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc401f9c6c0150600c028600c360405fa0
401f9c6c0150500c028600c360409fa0401f9c6c0150400c028600c360411fa0
401f9c6c00dd200c0186c0a30021dfa400009c6c009d007f828000c360409ffc
401f9c6c01d0b00d8086c0c360403fa8401f9c6c79d0a00d8086c0caa0b040a8
401f9c6c81d0900d8086c0caa0a480a800009c6c004000800286c08360403ffc
00009c6c004000550286c08360409ffc00009c6c011ce008028000c000619ffc
00009c6c011ce055828000c000607ffc00009c6c011ce008029540f540619ffc
00009c6c011ce055829540f540607ffc00009c6c0080002a8484014360419ffc
00009c6c0100000004ae814200a19ffc00009c6c00dce0000186c08200a19ffc
401f9c6c01d0800d8086c0c360411fa8401f9c6c011cf008028400d740619f9d
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 6 vars
Matrix 48 [_LightMatrix0] 4
Float 112 [_RotationSpeed]
Vector 128 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 32 instructions, 3 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjpcbecjookkaibaakppagkdhkgkbaeajabaaaaaaoiagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcemafaaaaeaaaabaa
fdabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
akiacaaaabaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaap
hcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaa
egbabaaaadaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaacaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaa
acaaaaaabgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaadaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_9;
  highp vec2 P_10;
  P_10 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_12;
  atten_12 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_10).w) * texture2D (_LightTextureB0, vec2(tmpvar_11)).w);
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_12) * 2.0));
  c_13.w = tmpvar_4;
  c_1.xyz = c_13.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_9;
  highp vec2 P_10;
  P_10 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_12;
  atten_12 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_10).w) * texture2D (_LightTextureB0, vec2(tmpvar_11)).w);
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_12) * 2.0));
  c_13.w = tmpvar_4;
  c_1.xyz = c_13.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 14 [unity_Scale]
Matrix 8 [_LightMatrix0]
Float 15 [_RotationSpeed]
Vector 16 [_MainTex_ST]
"agal_vs
c17 -0.5 0.159155 0.5 0.0
c18 6.283185 -3.141593 2.0 -1.0
c19 -0.000002 -0.000022 0.002604 0.00026
c20 -0.020833 -0.125 1.0 0.5
[bc]
aaaaaaaaaaaaabacapaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c15
adaaaaaaaaaaabacamaaaaoeabaaaaaaaaaaaaaaacaaaaaa mul r0.x, c12, r0.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaabbaaaaffabaaaaaa mul r0.x, r0.x, c17.y
abaaaaaaaaaaabacaaaaaaaaacaaaaaabbaaaakkabaaaaaa add r0.x, r0.x, c17.z
aiaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa frc r0.x, r0.x
adaaaaaaabaaabacaaaaaaaaacaaaaaabcaaaaoeabaaaaaa mul r1.x, r0.x, c18
abaaaaaaabaaabacabaaaaaaacaaaaaabcaaaaffabaaaaaa add r1.x, r1.x, c18.y
apaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sin r0.x, r1.x
baaaaaaaaaaaacacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa cos r0.y, r1.x
adaaaaaaaaaaamacaaaaaabaacaaaaaabbaaaakkabaaaaaa mul r0.zw, r0.xxyx, c17.z
abaaaaaaaaaaamacaaaaaaopacaaaaaabbaaaakkabaaaaaa add r0.zw, r0.wwzw, c17.z
adaaaaaaabaaadacaaaaaapoacaaaaaabcaaaakkabaaaaaa mul r1.xy, r0.zwww, c18.z
abaaaaaaabaaadacabaaaafeacaaaaaabcaaaappabaaaaaa add r1.xy, r1.xyyy, c18.w
abaaaaaaaaaaamacadaaaaeeaaaaaaaabbaaaaaaabaaaaaa add r0.zw, a3.xyxy, c17.x
adaaaaaaabaaadacaaaaaappacaaaaaaabaaaafeacaaaaaa mul r1.xy, r0.w, r1.xyyy
bfaaaaaaaaaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r0.y
adaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa mul r0.xy, r0.xyyy, c17.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa add r0.xy, r0.xyyy, c17.z
adaaaaaaaaaaadacaaaaaafeacaaaaaabcaaaakkabaaaaaa mul r0.xy, r0.xyyy, c18.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabcaaaappabaaaaaa add r0.xy, r0.xyyy, c18.w
adaaaaaaaaaaadacaaaaaakkacaaaaaaaaaaaafeacaaaaaa mul r0.xy, r0.z, r0.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaafeacaaaaaa add r0.xy, r0.xyyy, r1.xyyy
adaaaaaaabaaahacabaaaaoeaaaaaaaaaoaaaappabaaaaaa mul r1.xyz, a1, c14.w
abaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa add r0.xy, r0.xyyy, c17.z
adaaaaaaacaaadacaaaaaafeacaaaaaabaaaaaoeabaaaaaa mul r2.xy, r0.xyyy, c16
abaaaaaaaaaaadaeacaaaafeacaaaaaabaaaaaooabaaaaaa add v0.xy, r2.xyyy, c16.zwzw
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaadaaaiaeaaaaaaoeacaaaaaaalaaaaoeabaaaaaa dp4 v3.w, r0, c11
bdaaaaaaadaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v3.z, r0, c10
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v3.y, r0, c9
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v3.x, r0, c8
bcaaaaaaabaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r1.xyzz, c6
bcaaaaaaabaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r1.xyzz, c5
bcaaaaaaabaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r1.xyzz, c4
bfaaaaaaacaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r0.xyzz
abaaaaaaacaaahaeacaaaakeacaaaaaaanaaaaoeabaaaaaa add v2.xyz, r2.xyzz, c13
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 6 vars
Matrix 48 [_LightMatrix0] 4
Float 112 [_RotationSpeed]
Vector 128 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 32 instructions, 3 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedlbhielipgnlhakpjgcdnlffcdjmipaajabaaaaaamaakaaaaaeaaaaaa
daaaaaaaaeaeaaaafiajaaaacaakaaaaebgpgodjmmadaaaammadaaaaaaacpopp
fmadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
agaaabaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaacaaaaaaabaaaiaaaaaaaaaa
adaaaaaaaeaaajaaaaaaaaaaadaaamaaaeaaanaaaaaaaaaaadaabeaaabaabbaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbcaaapkaaaaaaalpidpjccdoaaaaaadp
aaaaiadofbaaaaafbdaaapkanlapmjeanlapejmagdibihlekblfmpdhfbaaaaaf
beaaapkalkajlglkkekkckdnaaaaiadpaaaaaamabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaabaaaaacaaaaabia
afaaaakaafaaaaadaaaaabiaaaaaaaiaahaaaakaaeaaaaaeaaaaapiaaaaaaaia
bcaaffkabcaalokabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeia
bdaaaakabdaaffkaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeabaaapia
aaaaoliabdaakkkabdaappkaaeaaaaaeabaaapiaaaaaoliaabaaoeiabeaaaaka
aeaaaaaeabaaapiaaaaaoliaabaaoeiabeaaffkaaeaaaaaeabaaapiaaaaaolia
abaaoeiabcaaaakaaeaaaaaeaaaaapiaaaaaoeiaabaaoeiabeaakkkaaeaaaaae
aaaaapiaaaaaoeiabcaaikkabcaakkkaaeaaaaaeaaaaapiaaaaaoeiabeaappkb
beaakkkbacaaaaadabaaapiaadaaeejabcaaaakaafaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaadiaaaaaoniaaaaaoiiaacaaaaadaaaaadiaaaaaoeia
bcaakkkaaeaaaaaeaaaaadoaaaaaoeiaagaaoekaagaaookaafaaaaadaaaaahia
acaaoejabbaappkaafaaaaadabaaahiaaaaaffiaaoaaoekaaeaaaaaeaaaaalia
anaakekaaaaaaaiaabaakeiaaeaaaaaeabaaahoaapaaoekaaaaakkiaaaaapeia
afaaaaadaaaaahiaaaaaffjaaoaaoekaaeaaaaaeaaaaahiaanaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahia
baaaoekaaaaappjaaaaaoeiaacaaaaadacaaahoaaaaaoeibaiaaoekaafaaaaad
aaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoeka
aaaappjaaaaaoeiaafaaaaadabaaapiaaaaaffiaacaaoekaaeaaaaaeabaaapia
abaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaadaaoekaaaaakkiaabaaoeia
aeaaaaaeadaaapoaaeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffja
akaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
alaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefcemafaaaaeaaaabaafdabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajbcaabaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaaakiacaaaabaaaaaaaaaaaaaaenaaaaah
bcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaaaaaaaaaadgaaaaafgcaabaaa
abaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaaadaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaacaaaaaaegaabaaaabaaaaaa
igaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaabgafbaaaabaaaaaaegaabaaa
aaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegaabaaaaaaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaeaaaaaaegiocaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 403
struct Input {
    highp vec2 uv_MainTex;
};
#line 427
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec4 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
#line 398
#line 402
uniform sampler2D _MainTex;
#line 408
uniform highp float _RotationSpeed;
#line 421
#line 436
uniform highp vec4 _MainTex_ST;
#line 77
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return (_WorldSpaceLightPos0.xyz - worldPos);
}
#line 409
void vert( inout appdata_full v ) {
    v.texcoord.xy -= 0.5;
    #line 412
    highp float s = float( sin((_RotationSpeed * _Time)));
    highp float c = float( cos((_RotationSpeed * _Time)));
    highp mat2 rotationMatrix = mat2( c, s, (-s), c);
    rotationMatrix *= 0.5;
    #line 416
    rotationMatrix += 0.5;
    rotationMatrix = ((rotationMatrix * 2.0) - 1.0);
    v.texcoord.xy = (v.texcoord.xy * rotationMatrix);
    v.texcoord.xy += 0.5;
}
#line 437
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 440
    vert( v);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 444
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 448
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 403
struct Input {
    highp vec2 uv_MainTex;
};
#line 427
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec4 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
#line 398
#line 402
uniform sampler2D _MainTex;
#line 408
uniform highp float _RotationSpeed;
#line 421
#line 436
uniform highp vec4 _MainTex_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 398
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 394
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 421
void surf( in Input IN, inout SurfaceOutput o ) {
    mediump vec4 c = texture( _MainTex, IN.uv_MainTex);
    o.Albedo = c.xyz;
    #line 425
    o.Alpha = c.w;
}
#line 450
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 452
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 456
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 460
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingLambert( o, lightDir, (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * 1.0));
    #line 464
    c.w = o.Alpha;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_Time]
Vector 14 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 15 [unity_Scale]
Matrix 9 [_LightMatrix0]
Float 16 [_RotationSpeed]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 61 ALU
PARAM c[22] = { { 0.5, 24.980801, -24.980801, 0.15915491 },
		state.matrix.mvp,
		program.local[5..17],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75, 0.25, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[13];
MUL R0.x, R0, c[16];
MUL R0.x, R0, c[0].w;
FRC R1.w, R0.x;
ADD R0.y, R0.x, -c[21].z;
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[18];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].yzyw;
ADD R0.xyz, -R1.w, c[18];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].yzyw;
ADD R1.xyz, R1, c[19].xyxw;
MAD R1.xyz, R1, R0, c[19].zwzw;
MAD R1.xyz, R1, R0, c[20].xyxw;
MAD R1.xyz, R1, R0, c[20].zwzw;
ADD R3.xyz, R3, c[19].xyxw;
MAD R3.xyz, R3, R2, c[19].zwzw;
MAD R3.xyz, R3, R2, c[20].xyxw;
MAD R1.xyz, R1, R0, c[18].wzww;
MAD R3.xyz, R3, R2, c[20].zwzw;
SLT R4.x, R1.w, c[21].z;
SGE R4.yz, R1.w, c[21].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[18].wzww;
DP3 R4.x, R1, -R0;
MAD R1.xyz, R3, R2, c[18].wzww;
SLT R0.x, R0.w, c[21].z;
SGE R0.yz, R0.w, c[21].xxyw;
DP3 R2.y, R0, c[18].wzww;
MOV R2.xz, R0;
DP3 R0.x, R1, -R2;
MOV R4.y, -R0.x;
MOV R0.y, R4.x;
MAD R0.xy, R0, c[0].x, c[0].x;
MUL R0.zw, R0.xyxy, c[21].w;
MAD R1.xy, R4, c[0].x, c[0].x;
MUL R0.xy, R1, c[21].w;
ADD R1.xy, R0.zwzw, -c[18].z;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R1.xy, R0.w, R1;
ADD R0.xy, R0, -c[18].z;
MAD R0.xy, R0.z, R0, R1;
MUL R1.xyz, vertex.normal, c[15].w;
ADD R0.xy, R0, c[0].x;
MAD result.texcoord[0].xy, R0, c[17], c[17].zwzw;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[3].z, R0, c[11];
DP4 result.texcoord[3].y, R0, c[10];
DP4 result.texcoord[3].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[14];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 61 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 14 [unity_Scale]
Matrix 8 [_LightMatrix0]
Float 15 [_RotationSpeed]
Vector 16 [_MainTex_ST]
"vs_2_0
; 41 ALU
def c17, -0.50000000, 0.15915491, 0.50000000, 0
def c18, 6.28318501, -3.14159298, 2.00000000, -1.00000000
def c19, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c20, -0.02083333, -0.12500000, 1.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c15
mul r0.x, c12, r0
mad r0.x, r0, c17.y, c17.z
frc r0.x, r0
mad r1.x, r0, c18, c18.y
sincos r0.xy, r1.x, c19.xyzw, c20.xyzw
mad r0.zw, r0.xyyx, c17.z, c17.z
mad r1.xy, r0.zwzw, c18.z, c18.w
add r0.zw, v3.xyxy, c17.x
mul r1.xy, r0.w, r1
mov r0.y, -r0
mad r0.xy, r0, c17.z, c17.z
mad r0.xy, r0, c18.z, c18.w
mad r0.xy, r0.z, r0, r1
mul r1.xyz, v2, c14.w
add r0.xy, r0, c17.z
mad oT0.xy, r0, c16, c16.zwzw
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT3.z, r0, c10
dp4 oT3.y, r0, c9
dp4 oT3.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
add oT2.xyz, -r0, c13
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "xbox360 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 11 [_LightMatrix0] 4
Vector 16 [_MainTex_ST]
Matrix 6 [_Object2World] 4
Float 15 [_RotationSpeed]
Vector 0 [_Time]
Vector 1 [_WorldSpaceLightPos0]
Matrix 2 [glstate_matrix_mvp] 4
Vector 10 [unity_Scale]
// Shader Timing Estimate, in Cycles/64 vertex vector:
// ALU: 32.00 (24 instructions), vertex: 32, texture: 0,
//   sequencer: 16,  5 GPRs, 31 threads,
// Performance (if enough threads): ~32 cycles per vector
// * Vertex cycle estimates are assuming 3 vfetch_minis for every vfetch_full,
//     with <= 32 bytes per vfetch_full group.

"vs_360
backbbabaaaaacbmaaaaabmaaaaaaaaaaaaaaaceaaaaabkaaaaaabmiaaaaaaaa
aaaaaaaaaaaaabhiaaaaaabmaaaaabgjpppoadaaaaaaaaaiaaaaaabmaaaaaaaa
aaaaabgcaaaaaalmaaacaaalaaaeaaaaaaaaaammaaaaaaaaaaaaaanmaaacaaba
aaabaaaaaaaaaaoiaaaaaaaaaaaaaapiaaacaaagaaaeaaaaaaaaaammaaaaaaaa
aaaaabagaaacaaapaaabaaaaaaaaabbiaaaaaaaaaaaaabciaaacaaaaaaabaaaa
aaaaaaoiaaaaaaaaaaaaabcoaaacaaabaaabaaaaaaaaaaoiaaaaaaaaaaaaabed
aaacaaacaaaeaaaaaaaaaammaaaaaaaaaaaaabfgaaacaaakaaabaaaaaaaaaaoi
aaaaaaaafpemgjghgiheengbhehcgjhidaaaklklaaadaaadaaaeaaaeaaabaaaa
aaaaaaaafpengbgjgofegfhifpfdfeaaaaabaaadaaabaaaeaaabaaaaaaaaaaaa
fpepgcgkgfgdhedcfhgphcgmgeaafpfcgphegbhegjgpgofdhagfgfgeaaklklkl
aaaaaaadaaabaaabaaabaaaaaaaaaaaafpfegjgngfaafpfhgphcgmgefdhagbgd
gfemgjghgihefagphddaaaghgmhdhegbhegffpgngbhehcgjhifpgnhghaaahfgo
gjhehjfpfdgdgbgmgfaahghdfpddfpdaaadccodacodcdadddfddcodaaaklklkl
aaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaabeaapmaabaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaeaaaaaabiaaadbaaaeaaaaaaaaaaaaaaaaaaaacmie
aaaaaaabaaaaaaadaaaaaaaeaaaaacjaaabaaaaeaaaadaafaacafaagaaaadafa
aaabhbfbaaachcfcaaadhdfdaaaababoaaaababeaaaababdaaaabablaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaamaejapnl
eamjapnlaaaaaaaaaaaaaaaadpaaaaaalpaaaaaalpiaaaaadoccpjidhabfdaae
aaaabcaamcaaaaaaaaaaeaahaaaabcaameaaaaaaaaaagaalgabbbcaabcaaaaaa
aaaagabhcabnbcaaccaaaaaaafpieaaaaaaaagiiaaaaaaaaafpiaaaaaaaaaeeh
aaaaaaaaafpibaaaaaaaaoehaaaaaaaamiapaaacaabliiaakbaeafaamiapaaac
aamgiiaaklaeaeacmiapaaacaalbdejeklaeadacmiapiadoaagmaadeklaeacac
beanaaaaaadcblgmibaaakapamcpaaacaablaablibaeajppmiapaaacaamgaaaa
klaeaiackibhabadaablleebibaaaiaamiahaaadaagmlemaklaaahadmiapaaac
aalbaaaaklaeahacmiadaaaaaamelaaakaabppaamiapaaacaagmffffklaeagac
miahiaacaelpmaaakaacabaamiahiaabaamgmaleklaaagadcmehaaadaamglegm
kbacaoaamiaeaaaaaamglbgmilaapopomiahaaadaalbmaleklacanadmabeabab
aclbgmmgkaabppaameciababaagmmgmgkbabppaamiahaaacaagmleleklacamad
miahiaadaablmaleklacalacmiadaaaaaalblagmmlaaabppmiadaaaaaabkmfla
olababaamiadiaaaaalalabkilaababaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "POINT_COOKIE" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_Time]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Vector 465 [unity_Scale]
Matrix 264 [_LightMatrix0]
Float 464 [_RotationSpeed]
Vector 463 [_MainTex_ST]
"sce_vp_rsx // 29 instructions using 3 registers
[Configuration]
8
0000001d01050300
[Defaults]
1
462 3
3f000000400000003f800000
[Microcode]
464
00009c6c009d120c013fc0c36041dffc00011c6c00dce8800186c08200419ffc
401f9c6c01d0300d8106c0c360403f80401f9c6c01d0200d8106c0c360405f80
401f9c6c01d0100d8106c0c360409f80401f9c6c01d0000d8106c0c360411f80
00001c6c01d0700d8106c0c360403ffc00009c6c005d30000186c08360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc401f9c6c0150600c028600c360405fa0
401f9c6c0150500c028600c360409fa0401f9c6c0150400c028600c360411fa0
401f9c6c00dd200c0186c0a30021dfa400009c6c009d007f828000c360409ffc
401f9c6c79d0a00d8086c0caa0b040a8401f9c6c81d0900d8086c0caa0a480a8
00009c6c004000800286c08360403ffc00009c6c004000550286c08360409ffc
00009c6c011ce008028000c000619ffc00009c6c011ce055828000c000607ffc
00009c6c011ce008029540f540619ffc00009c6c011ce055829540f540607ffc
00009c6c0080002a8484014360419ffc00009c6c0100000004ae814200a19ffc
00009c6c00dce0000186c08200a19ffc401f9c6c01d0800d8086c0c360411fa8
401f9c6c011cf008028400d740619f9d
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 6 vars
Matrix 48 [_LightMatrix0] 4
Float 112 [_RotationSpeed]
Vector 128 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 32 instructions, 3 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedggohdbpeejhhniahfadojalngfpaphekabaaaaaaoiagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcemafaaaaeaaaabaa
fdabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
akiacaaaabaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaap
hcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaa
egbabaaaadaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaacaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaa
acaaaaaabgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaadaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_11.w = tmpvar_4;
  c_1.xyz = c_11.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_11.w = tmpvar_4;
  c_1.xyz = c_11.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 14 [unity_Scale]
Matrix 8 [_LightMatrix0]
Float 15 [_RotationSpeed]
Vector 16 [_MainTex_ST]
"agal_vs
c17 -0.5 0.159155 0.5 0.0
c18 6.283185 -3.141593 2.0 -1.0
c19 -0.000002 -0.000022 0.002604 0.00026
c20 -0.020833 -0.125 1.0 0.5
[bc]
aaaaaaaaaaaaabacapaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c15
adaaaaaaaaaaabacamaaaaoeabaaaaaaaaaaaaaaacaaaaaa mul r0.x, c12, r0.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaabbaaaaffabaaaaaa mul r0.x, r0.x, c17.y
abaaaaaaaaaaabacaaaaaaaaacaaaaaabbaaaakkabaaaaaa add r0.x, r0.x, c17.z
aiaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa frc r0.x, r0.x
adaaaaaaabaaabacaaaaaaaaacaaaaaabcaaaaoeabaaaaaa mul r1.x, r0.x, c18
abaaaaaaabaaabacabaaaaaaacaaaaaabcaaaaffabaaaaaa add r1.x, r1.x, c18.y
apaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sin r0.x, r1.x
baaaaaaaaaaaacacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa cos r0.y, r1.x
adaaaaaaaaaaamacaaaaaabaacaaaaaabbaaaakkabaaaaaa mul r0.zw, r0.xxyx, c17.z
abaaaaaaaaaaamacaaaaaaopacaaaaaabbaaaakkabaaaaaa add r0.zw, r0.wwzw, c17.z
adaaaaaaabaaadacaaaaaapoacaaaaaabcaaaakkabaaaaaa mul r1.xy, r0.zwww, c18.z
abaaaaaaabaaadacabaaaafeacaaaaaabcaaaappabaaaaaa add r1.xy, r1.xyyy, c18.w
abaaaaaaaaaaamacadaaaaeeaaaaaaaabbaaaaaaabaaaaaa add r0.zw, a3.xyxy, c17.x
adaaaaaaabaaadacaaaaaappacaaaaaaabaaaafeacaaaaaa mul r1.xy, r0.w, r1.xyyy
bfaaaaaaaaaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r0.y
adaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa mul r0.xy, r0.xyyy, c17.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa add r0.xy, r0.xyyy, c17.z
adaaaaaaaaaaadacaaaaaafeacaaaaaabcaaaakkabaaaaaa mul r0.xy, r0.xyyy, c18.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabcaaaappabaaaaaa add r0.xy, r0.xyyy, c18.w
adaaaaaaaaaaadacaaaaaakkacaaaaaaaaaaaafeacaaaaaa mul r0.xy, r0.z, r0.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaafeacaaaaaa add r0.xy, r0.xyyy, r1.xyyy
adaaaaaaabaaahacabaaaaoeaaaaaaaaaoaaaappabaaaaaa mul r1.xyz, a1, c14.w
abaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa add r0.xy, r0.xyyy, c17.z
adaaaaaaacaaadacaaaaaafeacaaaaaabaaaaaoeabaaaaaa mul r2.xy, r0.xyyy, c16
abaaaaaaaaaaadaeacaaaafeacaaaaaabaaaaaooabaaaaaa add v0.xy, r2.xyyy, c16.zwzw
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaadaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v3.z, r0, c10
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v3.y, r0, c9
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v3.x, r0, c8
bcaaaaaaabaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r1.xyzz, c6
bcaaaaaaabaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r1.xyzz, c5
bcaaaaaaabaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r1.xyzz, c4
bfaaaaaaacaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r0.xyzz
abaaaaaaacaaahaeacaaaakeacaaaaaaanaaaaoeabaaaaaa add v2.xyz, r2.xyzz, c13
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 6 vars
Matrix 48 [_LightMatrix0] 4
Float 112 [_RotationSpeed]
Vector 128 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 32 instructions, 3 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedlikcglhmadgelpgobekdmdbglgnlgpmjabaaaaaamaakaaaaaeaaaaaa
daaaaaaaaeaeaaaafiajaaaacaakaaaaebgpgodjmmadaaaammadaaaaaaacpopp
fmadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
agaaabaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaacaaaaaaabaaaiaaaaaaaaaa
adaaaaaaaeaaajaaaaaaaaaaadaaamaaaeaaanaaaaaaaaaaadaabeaaabaabbaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbcaaapkaaaaaaalpidpjccdoaaaaaadp
aaaaiadofbaaaaafbdaaapkanlapmjeanlapejmagdibihlekblfmpdhfbaaaaaf
beaaapkalkajlglkkekkckdnaaaaiadpaaaaaamabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaabaaaaacaaaaabia
afaaaakaafaaaaadaaaaabiaaaaaaaiaahaaaakaaeaaaaaeaaaaapiaaaaaaaia
bcaaffkabcaalokabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeia
bdaaaakabdaaffkaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeabaaapia
aaaaoliabdaakkkabdaappkaaeaaaaaeabaaapiaaaaaoliaabaaoeiabeaaaaka
aeaaaaaeabaaapiaaaaaoliaabaaoeiabeaaffkaaeaaaaaeabaaapiaaaaaolia
abaaoeiabcaaaakaaeaaaaaeaaaaapiaaaaaoeiaabaaoeiabeaakkkaaeaaaaae
aaaaapiaaaaaoeiabcaaikkabcaakkkaaeaaaaaeaaaaapiaaaaaoeiabeaappkb
beaakkkbacaaaaadabaaapiaadaaeejabcaaaakaafaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaadiaaaaaoniaaaaaoiiaacaaaaadaaaaadiaaaaaoeia
bcaakkkaaeaaaaaeaaaaadoaaaaaoeiaagaaoekaagaaookaafaaaaadaaaaahia
acaaoejabbaappkaafaaaaadabaaahiaaaaaffiaaoaaoekaaeaaaaaeaaaaalia
anaakekaaaaaaaiaabaakeiaaeaaaaaeabaaahoaapaaoekaaaaakkiaaaaapeia
afaaaaadaaaaahiaaaaaffjaaoaaoekaaeaaaaaeaaaaahiaanaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahia
baaaoekaaaaappjaaaaaoeiaacaaaaadacaaahoaaaaaoeibaiaaoekaafaaaaad
aaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoeka
aaaappjaaaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahia
abaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeia
aeaaaaaeadaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
akaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
alaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefcemafaaaaeaaaabaafdabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajbcaabaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaaakiacaaaabaaaaaaaaaaaaaaenaaaaah
bcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaaaaaaaaaadgaaaaafgcaabaaa
abaaaaaaagaabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaalpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaaaaaaaakdcaabaaaabaaaaaaegbabaaaadaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaacaaaaaaegaabaaaabaaaaaa
igaabaaaaaaaaaaaapaaaaahccaabaaaacaaaaaabgafbaaaabaaaaaaegaabaaa
aaaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegaabaaaaaaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 395
struct Input {
    highp vec2 uv_MainTex;
};
#line 419
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
#line 400
uniform highp float _RotationSpeed;
#line 413
#line 428
uniform highp vec4 _MainTex_ST;
#line 77
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return (_WorldSpaceLightPos0.xyz - worldPos);
}
#line 401
void vert( inout appdata_full v ) {
    v.texcoord.xy -= 0.5;
    #line 404
    highp float s = float( sin((_RotationSpeed * _Time)));
    highp float c = float( cos((_RotationSpeed * _Time)));
    highp mat2 rotationMatrix = mat2( c, s, (-s), c);
    rotationMatrix *= 0.5;
    #line 408
    rotationMatrix += 0.5;
    rotationMatrix = ((rotationMatrix * 2.0) - 1.0);
    v.texcoord.xy = (v.texcoord.xy * rotationMatrix);
    v.texcoord.xy += 0.5;
}
#line 429
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 432
    vert( v);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 436
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 440
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 395
struct Input {
    highp vec2 uv_MainTex;
};
#line 419
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
#line 400
uniform highp float _RotationSpeed;
#line 413
#line 428
uniform highp vec4 _MainTex_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 413
void surf( in Input IN, inout SurfaceOutput o ) {
    mediump vec4 c = texture( _MainTex, IN.uv_MainTex);
    o.Albedo = c.xyz;
    #line 417
    o.Alpha = c.w;
}
#line 442
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 444
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 448
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 452
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingLambert( o, lightDir, ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * 1.0));
    #line 456
    c.w = o.Alpha;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_Time]
Vector 14 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 15 [unity_Scale]
Matrix 9 [_LightMatrix0]
Float 16 [_RotationSpeed]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 60 ALU
PARAM c[22] = { { 0.5, 24.980801, -24.980801, 0.15915491 },
		state.matrix.mvp,
		program.local[5..17],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75, 0.25, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[13];
MUL R0.x, R0, c[16];
MUL R0.x, R0, c[0].w;
FRC R1.w, R0.x;
ADD R0.y, R0.x, -c[21].z;
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[18];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].yzyw;
ADD R0.xyz, -R1.w, c[18];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].yzyw;
ADD R1.xyz, R1, c[19].xyxw;
MAD R1.xyz, R1, R0, c[19].zwzw;
MAD R1.xyz, R1, R0, c[20].xyxw;
MAD R1.xyz, R1, R0, c[20].zwzw;
ADD R3.xyz, R3, c[19].xyxw;
MAD R3.xyz, R3, R2, c[19].zwzw;
MAD R3.xyz, R3, R2, c[20].xyxw;
MAD R1.xyz, R1, R0, c[18].wzww;
MAD R3.xyz, R3, R2, c[20].zwzw;
SLT R4.x, R1.w, c[21].z;
SGE R4.yz, R1.w, c[21].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[18].wzww;
DP3 R4.x, R1, -R0;
MAD R1.xyz, R3, R2, c[18].wzww;
SLT R0.x, R0.w, c[21].z;
SGE R0.yz, R0.w, c[21].xxyw;
DP3 R2.y, R0, c[18].wzww;
MOV R2.xz, R0;
DP3 R0.x, R1, -R2;
MOV R4.y, -R0.x;
MOV R0.y, R4.x;
MAD R0.xy, R0, c[0].x, c[0].x;
MUL R0.zw, R0.xyxy, c[21].w;
MAD R1.xy, R4, c[0].x, c[0].x;
MUL R0.xy, R1, c[21].w;
ADD R1.xy, R0.zwzw, -c[18].z;
ADD R0.zw, vertex.texcoord[0].xyxy, -c[0].x;
MUL R1.xy, R0.w, R1;
ADD R0.xy, R0, -c[18].z;
MAD R0.xy, R0.z, R0, R1;
MUL R1.xyz, vertex.normal, c[15].w;
ADD R0.xy, R0, c[0].x;
MAD result.texcoord[0].xy, R0, c[17], c[17].zwzw;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[3].y, R0, c[10];
DP4 result.texcoord[3].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
MOV result.texcoord[2].xyz, c[14];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 60 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 14 [unity_Scale]
Matrix 8 [_LightMatrix0]
Float 15 [_RotationSpeed]
Vector 16 [_MainTex_ST]
"vs_2_0
; 40 ALU
def c17, -0.50000000, 0.15915491, 0.50000000, 0
def c18, 6.28318501, -3.14159298, 2.00000000, -1.00000000
def c19, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c20, -0.02083333, -0.12500000, 1.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c15
mul r0.x, c12, r0
mad r0.x, r0, c17.y, c17.z
frc r0.x, r0
mad r1.x, r0, c18, c18.y
sincos r0.xy, r1.x, c19.xyzw, c20.xyzw
mad r0.zw, r0.xyyx, c17.z, c17.z
mad r1.xy, r0.zwzw, c18.z, c18.w
add r0.zw, v3.xyxy, c17.x
mul r1.xy, r0.w, r1
mov r0.y, -r0
mad r0.xy, r0, c17.z, c17.z
mad r0.xy, r0, c18.z, c18.w
mad r0.xy, r0.z, r0, r1
mul r1.xyz, v2, c14.w
add r0.xy, r0, c17.z
mad oT0.xy, r0, c16, c16.zwzw
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT3.y, r0, c9
dp4 oT3.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
mov oT2.xyz, c13
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 11 [_LightMatrix0] 4
Vector 16 [_MainTex_ST]
Matrix 6 [_Object2World] 4
Float 15 [_RotationSpeed]
Vector 0 [_Time]
Vector 1 [_WorldSpaceLightPos0]
Matrix 2 [glstate_matrix_mvp] 4
Vector 10 [unity_Scale]
// Shader Timing Estimate, in Cycles/64 vertex vector:
// ALU: 33.33 (25 instructions), vertex: 32, texture: 0,
//   sequencer: 16,  5 GPRs, 31 threads,
// Performance (if enough threads): ~33 cycles per vector
// * Vertex cycle estimates are assuming 3 vfetch_minis for every vfetch_full,
//     with <= 32 bytes per vfetch_full group.

"vs_360
backbbabaaaaacbmaaaaabmmaaaaaaaaaaaaaaceaaaaabkaaaaaabmiaaaaaaaa
aaaaaaaaaaaaabhiaaaaaabmaaaaabgjpppoadaaaaaaaaaiaaaaaabmaaaaaaaa
aaaaabgcaaaaaalmaaacaaalaaaeaaaaaaaaaammaaaaaaaaaaaaaanmaaacaaba
aaabaaaaaaaaaaoiaaaaaaaaaaaaaapiaaacaaagaaaeaaaaaaaaaammaaaaaaaa
aaaaabagaaacaaapaaabaaaaaaaaabbiaaaaaaaaaaaaabciaaacaaaaaaabaaaa
aaaaaaoiaaaaaaaaaaaaabcoaaacaaabaaabaaaaaaaaaaoiaaaaaaaaaaaaabed
aaacaaacaaaeaaaaaaaaaammaaaaaaaaaaaaabfgaaacaaakaaabaaaaaaaaaaoi
aaaaaaaafpemgjghgiheengbhehcgjhidaaaklklaaadaaadaaaeaaaeaaabaaaa
aaaaaaaafpengbgjgofegfhifpfdfeaaaaabaaadaaabaaaeaaabaaaaaaaaaaaa
fpepgcgkgfgdhedcfhgphcgmgeaafpfcgphegbhegjgpgofdhagfgfgeaaklklkl
aaaaaaadaaabaaabaaabaaaaaaaaaaaafpfegjgngfaafpfhgphcgmgefdhagbgd
gfemgjghgihefagphddaaaghgmhdhegbhegffpgngbhehcgjhifpgnhghaaahfgo
gjhehjfpfdgdgbgmgfaahghdfpddfpdaaadccodacodcdadddfddcodaaaklklkl
aaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaabeaapmaabaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaeaaaaaabimaadbaaaeaaaaaaaaaaaaaaaaaaaaciie
aaaaaaabaaaaaaadaaaaaaaeaaaaacjaaabaaaaeaaaadaafaadafaagaaaadafa
aaabhbfbaaachcfcaaadddfdaaaababpaaaababeaaaababdaaaababnaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaamaejapnl
eamjapnlaaaaaaaaaaaaaaaalpaaaaaadpaaaaaalpiaaaaadoccpjidhabfdaae
aaaabcaamcaaaaaaaaaaeaahaaaabcaameaaaaaaaaaagaalgabbbcaabcaaaaaa
aaaagabhdabnbcaaccaaaaaaafpieaaaaaaaagiiaaaaaaaaafpibaaaaaaaaoii
aaaaaaaaafpiaaaaaaaaaohiaaaaaaaamiapaaacaabliiaakbaeafaamiapaaac
aamgiiaaklaeaeacmiapaaacaalbdejeklaeadacmiapiadoaagmaadeklaeacac
beahaaabaamnblgmibabakapamcpaaacaabliiblibaeajppmiapaaadaamgiiaa
klaeaiackichaaacaamgleebibabaiaamialaaacaagmlemaklabahacmiapaaad
aalbdejeklaeahadliefacababmfgniaiaaappppmiapaaadaagmnajeklaeagad
miahiaacaamamaaaccababaamiahiaabaalbmaliklabagaccmedaaaaaamglagm
kbadaoabmiaeaaaaaamglbgmilaapopomabkacabaabllmmgkbadanaamiakaaab
aalblmbbkladamabmiadaaabaagmlabjkladalabmeciacacaagmmgmgkbacppaa
miamaaaaaaagpbaaobacacaamiamaaabaamgkmlbmlabacppmiadiaadaalalaaa
oaabaaaamiadaaaaaabkbkaaoaabaaaamiadiaaaaalalabkilaababaaaaaaaaa
aaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL_COOKIE" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_Time]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Vector 465 [unity_Scale]
Matrix 264 [_LightMatrix0]
Float 464 [_RotationSpeed]
Vector 463 [_MainTex_ST]
"sce_vp_rsx // 28 instructions using 3 registers
[Configuration]
8
0000001c01050300
[Defaults]
1
462 3
3f000000400000003f800000
[Microcode]
448
401f9c6c005d200c0186c0836041dfa400009c6c009d120c013fc0c36041dffc
00011c6c00dce8800186c08200419ffc401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00009c6c005d30000186c08360403ffc
401f9c6c0150600c028600c360405fa0401f9c6c0150500c028600c360409fa0
00009c6c009d007f828000c360403ffc401f9c6c7950400c028600dfe0a50120
401f9c6c81d0900d8086c0dfe0b080a800009c6c004000d50486c08360409ffc
00011c6c004000000286c08360403ffc00009c6c011ce055848000c000607ffc
00009c6c011ce008028000c000619ffc00009c6c011ce055829540f540607ffc
00009c6c011ce008029540f540619ffc00009c6c0080002a84aac14360407ffc
00009c6c010000000484015740a19ffc00009c6c00dce0000186c08200a19ffc
401f9c6c01d0800d8086c0c360411fa8401f9c6c011cf008028400d740619f9d
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 6 vars
Matrix 48 [_LightMatrix0] 4
Float 112 [_RotationSpeed]
Vector 128 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 28 instructions, 3 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhbhdcifimlemkhjbahjiljpdbmpinjgjabaaaaaaeeagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckiaeaaaaeaaaabaa
ckabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
akiacaaaabaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaap
hcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaa
egbabaaaadaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaacaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaa
acaaaaaabgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakmccabaaaabaaaaaaagiecaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaagaebaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = c_9.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotationSpeed;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = _glesMultiTexCoord0.zw;
  tmpvar_3.xy = (_glesMultiTexCoord0.xy - 0.5);
  highp vec4 tmpvar_4;
  tmpvar_4 = sin((_RotationSpeed * _Time));
  highp float tmpvar_5;
  tmpvar_5 = cos((_RotationSpeed * _Time)).x;
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4.x;
  tmpvar_6[1].x = -(tmpvar_4.x);
  tmpvar_6[1].y = tmpvar_5;
  tmpvar_3.xy = (tmpvar_3.xy * ((((tmpvar_6 * 0.5) + 0.5) * 2.0) - 1.0));
  tmpvar_3.xy = (tmpvar_3.xy + 0.5);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((tmpvar_3.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = c_5.xyz;
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = c_5.w;
  tmpvar_4 = tmpvar_8;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = c_9.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 14 [unity_Scale]
Matrix 8 [_LightMatrix0]
Float 15 [_RotationSpeed]
Vector 16 [_MainTex_ST]
"agal_vs
c17 -0.5 0.159155 0.5 0.0
c18 6.283185 -3.141593 2.0 -1.0
c19 -0.000002 -0.000022 0.002604 0.00026
c20 -0.020833 -0.125 1.0 0.5
[bc]
aaaaaaaaaaaaabacapaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c15
adaaaaaaaaaaabacamaaaaoeabaaaaaaaaaaaaaaacaaaaaa mul r0.x, c12, r0.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaabbaaaaffabaaaaaa mul r0.x, r0.x, c17.y
abaaaaaaaaaaabacaaaaaaaaacaaaaaabbaaaakkabaaaaaa add r0.x, r0.x, c17.z
aiaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa frc r0.x, r0.x
adaaaaaaabaaabacaaaaaaaaacaaaaaabcaaaaoeabaaaaaa mul r1.x, r0.x, c18
abaaaaaaabaaabacabaaaaaaacaaaaaabcaaaaffabaaaaaa add r1.x, r1.x, c18.y
apaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sin r0.x, r1.x
baaaaaaaaaaaacacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa cos r0.y, r1.x
adaaaaaaaaaaamacaaaaaabaacaaaaaabbaaaakkabaaaaaa mul r0.zw, r0.xxyx, c17.z
abaaaaaaaaaaamacaaaaaaopacaaaaaabbaaaakkabaaaaaa add r0.zw, r0.wwzw, c17.z
adaaaaaaabaaadacaaaaaapoacaaaaaabcaaaakkabaaaaaa mul r1.xy, r0.zwww, c18.z
abaaaaaaabaaadacabaaaafeacaaaaaabcaaaappabaaaaaa add r1.xy, r1.xyyy, c18.w
abaaaaaaaaaaamacadaaaaeeaaaaaaaabbaaaaaaabaaaaaa add r0.zw, a3.xyxy, c17.x
adaaaaaaabaaadacaaaaaappacaaaaaaabaaaafeacaaaaaa mul r1.xy, r0.w, r1.xyyy
bfaaaaaaaaaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r0.y
adaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa mul r0.xy, r0.xyyy, c17.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa add r0.xy, r0.xyyy, c17.z
adaaaaaaaaaaadacaaaaaafeacaaaaaabcaaaakkabaaaaaa mul r0.xy, r0.xyyy, c18.z
abaaaaaaaaaaadacaaaaaafeacaaaaaabcaaaappabaaaaaa add r0.xy, r0.xyyy, c18.w
adaaaaaaaaaaadacaaaaaakkacaaaaaaaaaaaafeacaaaaaa mul r0.xy, r0.z, r0.xyyy
abaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaafeacaaaaaa add r0.xy, r0.xyyy, r1.xyyy
adaaaaaaabaaahacabaaaaoeaaaaaaaaaoaaaappabaaaaaa mul r1.xyz, a1, c14.w
abaaaaaaaaaaadacaaaaaafeacaaaaaabbaaaakkabaaaaaa add r0.xy, r0.xyyy, c17.z
adaaaaaaacaaadacaaaaaafeacaaaaaabaaaaaoeabaaaaaa mul r2.xy, r0.xyyy, c16
abaaaaaaaaaaadaeacaaaafeacaaaaaabaaaaaooabaaaaaa add v0.xy, r2.xyyy, c16.zwzw
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v3.y, r0, c9
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v3.x, r0, c8
bcaaaaaaabaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r1.xyzz, c6
bcaaaaaaabaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r1.xyzz, c5
bcaaaaaaabaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r1.xyzz, c4
aaaaaaaaacaaahaeanaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.xyz, c13
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 6 vars
Matrix 48 [_LightMatrix0] 4
Float 112 [_RotationSpeed]
Vector 128 [_MainTex_ST] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 28 instructions, 3 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedpfjocfkpgmdgdbojmjnecnpihjmbplgpabaaaaaammajaaaaaeaaaaaa
daaaaaaaleadaaaageaiaaaacmajaaaaebgpgodjhmadaaaahmadaaaaaaacpopp
amadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
agaaabaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaaacaaaaaaabaaaiaaaaaaaaaa
adaaaaaaaeaaajaaaaaaaaaaadaaamaaaeaaanaaaaaaaaaaadaabeaaabaabbaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbcaaapkaaaaaaalpidpjccdoaaaaaadp
aaaaiadofbaaaaafbdaaapkanlapmjeanlapejmagdibihlekblfmpdhfbaaaaaf
beaaapkalkajlglkkekkckdnaaaaiadpaaaaaamabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaabaaaaacaaaaabia
afaaaakaafaaaaadaaaaabiaaaaaaaiaahaaaakaaeaaaaaeaaaaapiaaaaaaaia
bcaaffkabcaalokabdaaaaacaaaaapiaaaaaoeiaaeaaaaaeaaaaapiaaaaaoeia
bdaaaakabdaaffkaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeabaaapia
aaaaoliabdaakkkabdaappkaaeaaaaaeabaaapiaaaaaoliaabaaoeiabeaaaaka
aeaaaaaeabaaapiaaaaaoliaabaaoeiabeaaffkaaeaaaaaeabaaapiaaaaaolia
abaaoeiabcaaaakaaeaaaaaeaaaaapiaaaaaoeiaabaaoeiabeaakkkaaeaaaaae
aaaaapiaaaaaoeiabcaaikkabcaakkkaaeaaaaaeaaaaapiaaaaaoeiabeaappkb
beaakkkbacaaaaadabaaapiaadaaeejabcaaaakaafaaaaadaaaaapiaaaaaoeia
abaaoeiaacaaaaadaaaaadiaaaaaoniaaaaaoiiaacaaaaadaaaaadiaaaaaoeia
bcaakkkaaeaaaaaeaaaaadoaaaaaoeiaagaaoekaagaaookaafaaaaadaaaaahia
acaaoejabbaappkaafaaaaadabaaahiaaaaaffiaaoaaoekaaeaaaaaeaaaaalia
anaakekaaaaaaaiaabaakeiaaeaaaaaeabaaahoaapaaoekaaaaakkiaaaaapeia
afaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
baaaoekaaaaappjaaaaaoeiaafaaaaadabaaadiaaaaaffiaacaaobkaaeaaaaae
aaaaadiaabaaobkaaaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaobkaaaaakkia
aaaaoeiaaeaaaaaeaaaaamoaaeaabekaaaaappiaaaaaeeiaafaaaaadaaaaapia
aaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaahoaaiaaoekappppaaaafdeieefckiaeaaaaeaaaabaa
ckabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
akiacaaaabaaaaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaadgaaaaafgcaabaaaabaaaaaaagaabaaaaaaaaaaadcaaaaap
hcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaalpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaaaaaaakdcaabaaaabaaaaaa
egbabaaaadaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaacaaaaaaegaabaaaabaaaaaaigaabaaaaaaaaaaaapaaaaahccaabaaa
acaaaaaabgafbaaaabaaaaaaegaabaaaaaaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakmccabaaaabaaaaaaagiecaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaagaebaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
};
#line 418
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec2 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
#line 399
uniform highp float _RotationSpeed;
#line 412
#line 427
uniform highp vec4 _MainTex_ST;
#line 77
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return _WorldSpaceLightPos0.xyz;
}
#line 400
void vert( inout appdata_full v ) {
    v.texcoord.xy -= 0.5;
    #line 403
    highp float s = float( sin((_RotationSpeed * _Time)));
    highp float c = float( cos((_RotationSpeed * _Time)));
    highp mat2 rotationMatrix = mat2( c, s, (-s), c);
    rotationMatrix *= 0.5;
    #line 407
    rotationMatrix += 0.5;
    rotationMatrix = ((rotationMatrix * 2.0) - 1.0);
    v.texcoord.xy = (v.texcoord.xy * rotationMatrix);
    v.texcoord.xy += 0.5;
}
#line 428
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 431
    vert( v);
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 435
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 439
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.normal);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec2(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
};
#line 418
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec2 _LightCoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
#line 399
uniform highp float _RotationSpeed;
#line 412
#line 427
uniform highp vec4 _MainTex_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    mediump vec4 c = texture( _MainTex, IN.uv_MainTex);
    o.Albedo = c.xyz;
    #line 416
    o.Alpha = c.w;
}
#line 441
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 443
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 447
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 451
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingLambert( o, lightDir, (texture( _LightTexture0, IN._LightCoord).w * 1.0));
    #line 455
    c.w = o.Alpha;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.normal = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 8 to 19, TEX: 1 to 3
//   d3d9 - ALU: 8 to 18, TEX: 1 to 3
//   d3d11 - ALU: 5 to 15, TEX: 1 to 3, FLOW: 1 to 1
//   d3d11_9x - ALU: 5 to 15, TEX: 1 to 3, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"!!ARBfp1.0
# 13 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, c[0];
MOV result.color.w, R0;
TEX R1.w, R1.x, texture[1], 2D;
DP3 R1.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, fragment.texcoord[2];
DP3 R1.x, fragment.texcoord[1], R1;
MAX R1.x, R1, c[1];
MUL R1.x, R1, R1.w;
MUL R0.xyz, R1.x, R0;
MUL result.color.xyz, R0, c[1].y;
END
# 13 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"ps_2_0
; 13 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r1, t0, s0
dp3 r0.x, t3, t3
mov r0.xy, r0.x
mul_pp r1.xyz, r1, c0
mov_pp r0.w, r1
texld r2, r0, s1
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t2
dp3_pp r0.x, t1, r0
max_pp r0.x, r0, c1
mul_pp r0.x, r0, r2
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp oC0, r0
"
}

SubProgram "xbox360 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_MainTex] 2D
// Shader Timing Estimate, in Cycles/64 pixel vector:
// ALU: 12.00 (9 instructions), vertex: 0, texture: 8,
//   sequencer: 8, interpolator: 16;    4 GPRs, 48 threads,
// Performance (if enough threads): ~16 cycles per vector
// * Texture cycle estimates are assuming an 8bit/component texture with no
//     aniso or trilinear filtering.

"ps_360
backbbaaaaaaabdeaaaaaaoiaaaaaaaaaaaaaaceaaaaaanmaaaaabaeaaaaaaaa
aaaaaaaaaaaaaaleaaaaaabmaaaaaakippppadaaaaaaaaadaaaaaabmaaaaaaaa
aaaaaakbaaaaaafiaaacaaaaaaabaaaaaaaaaagiaaaaaaaaaaaaaahiaaadaaaa
aaabaaaaaaaaaaiiaaaaaaaaaaaaaajiaaadaaabaaabaaaaaaaaaaiiaaaaaaaa
fpemgjghgiheedgpgmgphcdaaaklklklaaabaaadaaabaaaeaaabaaaaaaaaaaaa
fpemgjghgihefegfhihehfhcgfdaaaklaaaeaaamaaabaaabaaabaaaaaaaaaaaa
fpengbgjgofegfhiaahahdfpddfpdaaadccodacodcdadddfddcodaaaaaaaaaaa
aaaaaaabaaaaaaaaaaaaaaaaaaaaaabeabpmaabaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaakibaaaadaaaaaaaaaeaaaaaaaaaaaacmieaaapaaap
aaaaaaabaaaadafaaaaahbfbaaaahcfcaaaahdfdaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabedaacaaaabcaameaaaaaa
aaaagaafcaalbcaaccaaaaaamiaeaaaaaaloloaapaadadaakiaibaabbpbppbpp
aaaaeaaababiaaabbpbppgiiaaaaeaaamiaiaaacaaloloaapaacacaafiihacad
aaleleblkbaaaaicmiahaaacaablmaaaobacacaamiabaaabaaloloaapaacabaa
aaibadabaagmgmblkcabppabmiadaaaaaabigmaaobadabaamiabiaaaaagmblaa
obaaadaabeigiaaaaalglbblobadaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"sce_fp_rsx // 13 instructions using 3 registers
[Configuration]
24
ffffffff0003c020000ffff1000000000000840003000000
[Offsets]
1
_LightColor0 1 0
00000080
[Microcode]
208
ee040100c8011c9dc8000001c8003fe108000500c8081c9dc8080001c8000001
9e021700c8011c9dc8000001c8003fe1ce803940c8011c9dc8000029c800bfe1
10800140c8041c9dc8000001c8000001a8800540c8011c9dc9000001c8003fe1
0200170254001c9dc8000001c80000010e820240c8041c9dc8020001c8000001
000000000000000000000000000000001082090055001c9dc8020001c8000001
0000000000000000000000000000000002800240ff041c9dc8000001c8000001
0e81024001001c9cc9041001c8000001
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
ConstBuffer "$Globals" 144 // 32 used size, 6 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
// 13 instructions, 2 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjlkopjacfkojibaphafpnfdoaeeegcepabaaaaaapeacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcomabaaaaeaaaaaaahlaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"agal_ps
c1 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
ciaaaaaaaaaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r0, r0.xyyy, s1 <2d wrap linear point>
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r0.xyz, r0.x, v2
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v1, r0.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa max r0.x, r0.x, c1
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT" }
ConstBuffer "$Globals" 144 // 32 used size, 6 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
// 13 instructions, 2 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedncghegjchlalcdeoelpjegcneeajplenabaaaaaafiaeaaaaaeaaaaaa
daaaaaaajaabaaaaieadaaaaceaeaaaaebgpgodjfiabaaaafiabaaaaaaacpppp
caabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaaahlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaaiaaaaadaaaaaiiaadaaoela
adaaoelaabaaaaacaaaaadiaaaaappiaecaaaaadaaaacpiaaaaaoeiaaaaioeka
ecaaaaadabaacpiaaaaaoelaabaioekaceaaaaacacaachiaacaaoelaaiaaaaad
aaaacciaabaaoelaacaaoeiaafaaaaadaaaacbiaaaaaaaiaaaaaffiafiaaaaae
aaaacbiaaaaaffiaaaaaaaiaabaaaakaacaaaaadaaaacbiaaaaaaaiaaaaaaaia
afaaaaadaaaacoiaabaabliaaaaablkaafaaaaadabaachiaaaaaaaiaaaaablia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcomabaaaaeaaaaaaahlaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaa
aaaaaaaaagaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaaagajbaaa
abaaaaaaagijcaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 8 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MOV R1.xyz, fragment.texcoord[2];
DP3 R1.x, fragment.texcoord[1], R1;
MUL R0.xyz, R0, c[0];
MAX R1.x, R1, c[1];
MUL R0.xyz, R1.x, R0;
MUL result.color.xyz, R0, c[1].y;
MOV result.color.w, R0;
END
# 8 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 8 ALU, 1 TEX
dcl_2d s0
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
texld r1, t0, s0
mov_pp r0.xyz, t2
dp3_pp r0.x, t1, r0
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c1
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
// Shader Timing Estimate, in Cycles/64 pixel vector:
// ALU: 5.33 (4 instructions), vertex: 0, texture: 4,
//   sequencer: 6, interpolator: 12;    3 GPRs, 63 threads,
// Performance (if enough threads): ~12 cycles per vector
// * Texture cycle estimates are assuming an 8bit/component texture with no
//     aniso or trilinear filtering.

"ps_360
backbbaaaaaaabbaaaaaaakaaaaaaaaaaaaaaaceaaaaaalmaaaaaaoeaaaaaaaa
aaaaaaaaaaaaaajeaaaaaabmaaaaaaihppppadaaaaaaaaacaaaaaabmaaaaaaaa
aaaaaaiaaaaaaaeeaaacaaaaaaabaaaaaaaaaafeaaaaaaaaaaaaaageaaadaaaa
aaabaaaaaaaaaahaaaaaaaaafpemgjghgiheedgpgmgphcdaaaklklklaaabaaad
aaabaaaeaaabaaaaaaaaaaaafpengbgjgofegfhiaaklklklaaaeaaamaaabaaab
aaabaaaaaaaaaaaahahdfpddfpdaaadccodacodcdadddfddcodaaaklaaaaaaaa
aaaaaaabaaaaaaaaaaaaaaaaaaaaaabeabpmaabaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaagabaaaacaaaaaaaaaeaaaaaaaaaaaacagdaaahaaah
aaaaaaabaaaadafaaaaahbfbaaaahcfcaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbaacaaaabcaameaaaaaaaaaaeaad
aaaaccaaaaaaaaaabaaiaaabbpbppgiiaaaaeaaamiabaaabaaloloaapaabacaa
miabaaabaagmgmaakcabppaaaaboababaapmpmgmkbaaaaabbeihiaaaaabfgmbl
obababaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
"sce_fp_rsx // 9 instructions using 2 registers
[Configuration]
24
ffffffff0001c0200007fff9000000000000840002000000
[Offsets]
1
_LightColor0 1 0
00000040
[Microcode]
144
ce800140c8011c9dc8000001c8003fe19e021700c8011c9dc8000001c8003fe1
10800140c8041c9dc8000001c80000010e820240c8041c9dc8020001c8000001
00000000000000000000000000000000a2800540c8011c9dc9000001c8003fe1
02800900c9001c9d00020000c800000100000000000000000000000000000000
0e81024001001c9cc9041001c8000001
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 80 // 32 used size, 5 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
// 8 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjjpljccglkaahndimhhfhjnblgdlocpiabaaaaaaciacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdiabaaaaeaaaaaaaeoaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaadaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaa
agajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
"agal_ps
c1 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaahacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, v2
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v1, r0.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa max r0.x, r0.x, c1
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 80 // 32 used size, 5 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
// 8 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedmcmaklcfdpbdembkcbfmopacnckpagmaabaaaaaadaadaaaaaeaaaaaa
daaaaaaadeabaaaaheacaaaapmacaaaaebgpgodjpmaaaaaapmaaaaaaaaacpppp
miaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpia
aaaaoelaaaaioekaabaaaaacabaaahiaabaaoelaaiaaaaadabaacbiaabaaoeia
acaaoelaalaaaaadacaaciiaabaaaaiaabaaaakaacaaaaadabaacbiaacaappia
acaappiaafaaaaadabaacoiaaaaabliaaaaablkaafaaaaadaaaachiaabaaaaia
abaabliaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdiabaaaaeaaaaaaa
eoaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
adaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
SetTexture 2 [_LightTextureB0] 2D
"!!ARBfp1.0
# 19 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R2, fragment.texcoord[0], texture[0], 2D;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
RCP R0.x, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R0.x, c[1].y;
MUL R1.xyz, R2, c[0];
MOV result.color.w, R2;
TEX R0.w, R0, texture[1], 2D;
TEX R1.w, R0.z, texture[2], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[1], R0;
SLT R0.y, c[1].x, fragment.texcoord[3].z;
MUL R0.y, R0, R0.w;
MUL R0.y, R0, R1.w;
MAX R0.x, R0, c[1];
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[1].z;
END
# 19 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
SetTexture 2 [_LightTextureB0] 2D
"ps_2_0
; 18 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.50000000, 0.00000000, 1.00000000, 2.00000000
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3
texld r2, t0, s0
dp3 r1.x, t3, t3
mov r1.xy, r1.x
rcp r0.x, t3.w
mad r0.xy, t3, r0.x, c1.x
mul_pp r2.xyz, r2, c0
texld r3, r1, s2
texld r0, r0, s1
cmp r0.x, -t3.z, c1.y, c1.z
mul_pp r0.x, r0, r0.w
dp3_pp r1.x, t2, t2
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, t2
dp3_pp r1.x, t1, r1
mul_pp r0.x, r0, r3
max_pp r1.x, r1, c1.y
mul_pp r0.x, r1, r0
mul_pp r0.xyz, r0.x, r2
mul_pp r0.xyz, r0, c1.w
mov_pp r0.w, r2
mov_pp oC0, r0
"
}

SubProgram "xbox360 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_LightTextureB0] 2D
SetTexture 2 [_MainTex] 2D
// Shader Timing Estimate, in Cycles/64 pixel vector:
// ALU: 16.00 (12 instructions), vertex: 0, texture: 12,
//   sequencer: 8, interpolator: 16;    5 GPRs, 36 threads,
// Performance (if enough threads): ~16 cycles per vector
// * Texture cycle estimates are assuming an 8bit/component texture with no
//     aniso or trilinear filtering.

"ps_360
backbbaaaaaaabfiaaaaabbiaaaaaaaaaaaaaaceaaaaabaaaaaaabciaaaaaaaa
aaaaaaaaaaaaaaniaaaaaabmaaaaaammppppadaaaaaaaaaeaaaaaabmaaaaaaaa
aaaaaamfaaaaaagmaaacaaaaaaabaaaaaaaaaahmaaaaaaaaaaaaaaimaaadaaaa
aaabaaaaaaaaaajmaaaaaaaaaaaaaakmaaadaaabaaabaaaaaaaaaajmaaaaaaaa
aaaaaalmaaadaaacaaabaaaaaaaaaajmaaaaaaaafpemgjghgiheedgpgmgphcda
aaklklklaaabaaadaaabaaaeaaabaaaaaaaaaaaafpemgjghgihefegfhihehfhc
gfdaaaklaaaeaaamaaabaaabaaabaaaaaaaaaaaafpemgjghgihefegfhihehfhc
gfecdaaafpengbgjgofegfhiaahahdfpddfpdaaadccodacodcdadddfddcodaaa
aaaaaaaaaaaaaaabaaaaaaaaaaaaaaaaaaaaaabeabpmaabaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaeaaaaaaanibaaaaeaaaaaaaaaeaaaaaaaaaaaadaie
aaapaaapaaaaaaabaaaadafaaaaahbfbaaaahcfcaaaapdfdaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaabfafaacaaaabcaa
meaaaaaaaaaagaaheaanbcaaccaaaaaaemeiaaabaaloloblpaadadadmiamaaaa
aamgkmlbmlaaadpppmbicacbbpbppbppaaaaeaaaliaieaabbpbpppplaaaaeaaa
baciaaabbpbppgecaaaaeaaacabaadaaaaaaaamgocaaaaadbeciaaabaalololb
paacacaafiibabadaagmgmblobaeadibmiabaaadaagmblgmnbadacppkichadac
aablmaebmbabacaakiebadabaaloloicnaacabaakiibadabaagmgmmaicabppaa
miadaaabaabigmaaobadabaamiaeiaaaaalbgmaaobabadaabeidiaaaaamfgmbl
obadabaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
SetTexture 2 [_LightTextureB0] 2D
"sce_fp_rsx // 21 instructions using 2 registers
[Configuration]
24
ffffffff0003c020000ffff1000000000000840002000000
[Offsets]
1
_LightColor0 1 0
00000120
[Microcode]
336
fe000100c8011c9dc8000001c8003fe102020500c8001c9dc8000001c8000001
18023a0080001c9cfe000001c80000010200170400041c9cc8000001c8000001
060203005c041c9d00020000c800000100003f00000000000000000000000000
10800d0054001c9daa020000c800000100000000000000000000000000000000
10001702c8041c9dc8000001c8000001ce843940c8011c9dc8000029c800bfe1
10800240c9001c9dc8000001c8000001a8800540c8011c9dc9080001c8003fe1
9e021700c8011c9dc8000001c8003fe102800240ff001c9dc8000001c8000001
1080090055001c9d00020000c800000100000000000000000000000000000000
10820240c9001c9d01000000c80000010e820240c8041c9dc8020001c8000001
000000000000000000000000000000000e800240ff041c9dc9041001c8000001
10810140c8041c9dc8000001c8000001
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 144 // 32 used size, 6 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
// 20 instructions, 2 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 1 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedaliomoeopmlpalmjdjbdniopapppaackabaaaaaaoiadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoaacaaaaeaaaaaaaliaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaadaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaacaaaaaajgahbaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaiocaabaaaaaaaaaaa
agajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
SetTexture 2 [_LightTextureB0] 2D
"agal_ps
c1 0.5 0.0 1.0 2.0
[bc]
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
afaaaaaaabaaabacadaaaappaeaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, v3.w
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
adaaaaaaabaaadacadaaaaoeaeaaaaaaabaaaaaaacaaaaaa mul r1.xy, v3, r1.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaaaaabaaaaaa add r1.xy, r1.xyyy, c1.x
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, r2.xyzz, c0
ciaaaaaaabaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r1, r1.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaacaaaaaaafaababb tex r0, r0.xyyy, s2 <2d wrap linear point>
bfaaaaaaadaaaeacadaaaakkaeaaaaaaaaaaaaaaaaaaaaaa neg r3.z, v3.z
ckaaaaaaaaaaabacadaaaakkacaaaaaaabaaaaffabaaaaaa slt r0.x, r3.z, c1.y
adaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaappacaaaaaa mul r0.x, r0.x, r1.w
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
bcaaaaaaabaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r1.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.x, v2
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v1, r1.xyzz
ahaaaaaaabaaabacabaaaaaaacaaaaaaabaaaaffabaaaaaa max r1.x, r1.x, c1.y
adaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r0.x, r1.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r0.xyz, r0.x, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaappabaaaaaa mul r0.xyz, r0.xyzz, c1.w
aaaaaaaaaaaaaiacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r2.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 144 // 32 used size, 6 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
// 20 instructions, 2 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 1 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedifmknjlbnklkofdjdanaednklobjadfdabaaaaaakmafaaaaaeaaaaaa
daaaaaaapaabaaaaniaeaaaahiafaaaaebgpgodjliabaaaaliabaaaaaaacpppp
hmabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaabaaaaaa
acababaaaaacacaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapka
aaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaagaaaaacaaaaaiiaadaapplaaeaaaaaeaaaaadiaadaaoelaaaaappia
abaaaakaaiaaaaadabaaaiiaadaaoelaadaaoelaabaaaaacabaaadiaabaappia
ecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpiaabaaoeiaabaioeka
ecaaaaadacaacpiaaaaaoelaacaioekaafaaaaadaaaacbiaaaaappiaabaaaaia
fiaaaaaeaaaacbiaadaakklbabaaffkaaaaaaaiaceaaaaacabaachiaacaaoela
aiaaaaadaaaacciaabaaoelaabaaoeiaalaaaaadabaacbiaaaaaffiaabaaffka
afaaaaadaaaacbiaaaaaaaiaabaaaaiaacaaaaadaaaacbiaaaaaaaiaaaaaaaia
afaaaaadaaaacoiaacaabliaaaaablkaafaaaaadacaachiaaaaaaaiaaaaablia
abaaaaacaaaicpiaacaaoeiappppaaaafdeieefcoaacaaaaeaaaaaaaliaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaa
aeaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaackbabaaaaeaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagbjbaaaadaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaa
jgahbaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadoaaaaabejfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTextureB0] 2D
SetTexture 2 [_LightTexture0] CUBE
"!!ARBfp1.0
# 15 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[3], texture[2], CUBE;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
MUL R1.xyz, R2, c[0];
MOV result.color.w, R2;
TEX R0.w, R0.x, texture[1], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
DP3 R0.x, fragment.texcoord[1], R0;
MUL R0.y, R0.w, R1.w;
MAX R0.x, R0, c[1];
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[1].y;
END
# 15 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTextureB0] 2D
SetTexture 2 [_LightTexture0] CUBE
"ps_2_0
; 14 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r2, t3, s2
texld r1, t0, s0
dp3_pp r2.x, t2, t2
dp3 r0.x, t3, t3
mov r0.xy, r0.x
rsq_pp r2.x, r2.x
mul_pp r2.xyz, r2.x, t2
dp3_pp r2.x, t1, r2
mul_pp r1.xyz, r1, c0
max_pp r2.x, r2, c1
texld r0, r0, s1
mul r0.x, r0, r2.w
mul_pp r0.x, r2, r0
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "xbox360 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] CUBE
SetTexture 1 [_LightTextureB0] 2D
SetTexture 2 [_MainTex] 2D
// Shader Timing Estimate, in Cycles/64 pixel vector:
// ALU: 17.33 (13 instructions), vertex: 0, texture: 12,
//   sequencer: 10, interpolator: 16;    5 GPRs, 36 threads,
// Performance (if enough threads): ~17 cycles per vector
// * Texture cycle estimates are assuming an 8bit/component texture with no
//     aniso or trilinear filtering.

"ps_360
backbbaaaaaaabgiaaaaabdaaaaaaaaaaaaaaaceaaaaabbaaaaaabdiaaaaaaaa
aaaaaaaaaaaaaaoiaaaaaabmaaaaaanmppppadaaaaaaaaaeaaaaaabmaaaaaaaa
aaaaaanfaaaaaagmaaacaaaaaaabaaaaaaaaaahmaaaaaaaaaaaaaaimaaadaaaa
aaabaaaaaaaaaajmaaaaaaaaaaaaaakmaaadaaabaaabaaaaaaaaaalmaaaaaaaa
aaaaaammaaadaaacaaabaaaaaaaaaalmaaaaaaaafpemgjghgiheedgpgmgphcda
aaklklklaaabaaadaaabaaaeaaabaaaaaaaaaaaafpemgjghgihefegfhihehfhc
gfdaaaklaaaeaaaoaaabaaabaaabaaaaaaaaaaaafpemgjghgihefegfhihehfhc
gfecdaaaaaaeaaamaaabaaabaaabaaaaaaaaaaaafpengbgjgofegfhiaahahdfp
ddfpdaaadccodacodcdadddfddcodaaaaaaaaaaaaaaaaaabaaaaaaaaaaaaaaaa
aaaaaabeabpmaabaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaapa
baaaaeaaaaaaaaaeaaaaaaaaaaaacmieaaapaaapaaaaaaabaaaadafaaaaahbfb
aaaahcfcaaaahdfdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadpmaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaafaagaadbaajbcaabcaaaaabaaaaaaaagaakmeaabcaaaaaa
aaaadabaaaaaccaaaaaaaaaamiaeaaaaaaloloaapaadadaamiapaaadaakgmnaa
pcadadaaemieaaaeaablblmgocadadidmiadaaaeaagnblgmmladaappjaaidaib
bpbpppplaaaamaaakibicaabbpbppbppaaaaeaaabaciaaabbpbppgiiaaaaeaaa
miaiaaabaaloloaapaacacaamiaiaaadaagmbllbnbadacppfiihabadaalelebl
kbaaaaibmiahaaacaablmaaaobabacaamiabaaabaaloloaapaacabaamiabaaab
aagmlbaakcabppaamiadaaaaaabigmaaobadabaamiabiaaaaagmblaaobaaadaa
beigiaaaaalglbblobadaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTextureB0] 2D
SetTexture 2 [_LightTexture0] CUBE
"sce_fp_rsx // 16 instructions using 3 registers
[Configuration]
24
ffffffff0003c020000ffff1000000000000840003000000
[Offsets]
1
_LightColor0 1 0
000000e0
[Microcode]
256
ee040100c8011c9dc8000001c8003fe108000500c8081c9dc8080001c8000001
9e021700c8011c9dc8000001c8003fe1ce803940c8011c9dc8000029c800bfe1
10800140c8041c9dc8000001c8000001f0001704c8011c9dc8000001c8003fe1
1e7e7d00c8001c9dc8000001c8000001a8800540c8011c9dc9000001c8003fe1
0200170254001c9dc8000001c800000102800200c8001c9dfe000001c8000001
1082090055001c9d00020000c800000100000000000000000000000000000000
10820240c9041c9d01000000c80000010e820240c8041c9dc8020001c8000001
000000000000000000000000000000000e810240ff041c9dc9041001c8000001
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 144 // 32 used size, 6 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
// 15 instructions, 3 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkjobhbhlmencgfafbehgndpbplphpmmiabaaaaaafaadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefceiacaaaaeaaaaaaajcaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaafgafbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbcbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTextureB0] 2D
SetTexture 2 [_LightTexture0] CUBE
"agal_ps
c1 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, r2.xyzz, c0
ciaaaaaaabaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r1, r0.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacadaaaaoeaeaaaaaaacaaaaaaafbababb tex r0, v3, s2 <cube wrap linear point>
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r0.x
adaaaaaaaaaaabacabaaaappacaaaaaaaaaaaappacaaaaaa mul r0.x, r1.w, r0.w
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.x, v2
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v1, r1.xyzz
ahaaaaaaabaaabacabaaaaaaacaaaaaaabaaaaoeabaaaaaa max r1.x, r1.x, c1
adaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r0.x, r1.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r0.xyz, r0.x, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
aaaaaaaaaaaaaiacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r2.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 144 // 32 used size, 6 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
// 15 instructions, 3 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedegdpblijhjcgbpciaamlpkdhlicifhodabaaaaaaoaaeaaaaaeaaaaaa
daaaaaaalmabaaaaamaeaaaakmaeaaaaebgpgodjieabaaaaieabaaaaaaacpppp
eiabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaacaaaaaa
abababaaaaacacaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaaahla
bpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaaiaaaaadaaaaaiiaadaaoelaadaaoelaabaaaaacaaaaadiaaaaappia
ecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadabaaapiaadaaoelaaaaioeka
ecaaaaadacaacpiaaaaaoelaacaioekaafaaaaadaaaacbiaaaaaaaiaabaappia
ceaaaaacabaachiaacaaoelaaiaaaaadaaaacciaabaaoelaabaaoeiaalaaaaad
abaacbiaaaaaffiaabaaaakaafaaaaadaaaacbiaaaaaaaiaabaaaaiaacaaaaad
aaaacbiaaaaaaaiaaaaaaaiaafaaaaadaaaacoiaacaabliaaaaablkaafaaaaad
acaachiaaaaaaaiaaaaabliaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefc
eiacaaaaeaaaaaaajcaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbcbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaiocaabaaa
aaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"!!ARBfp1.0
# 10 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[3], texture[1], 2D;
MOV R1.xyz, fragment.texcoord[2];
DP3 R1.x, fragment.texcoord[1], R1;
MAX R1.x, R1, c[1];
MUL R0.xyz, R0, c[0];
MUL R1.x, R1, R1.w;
MUL R0.xyz, R1.x, R0;
MUL result.color.xyz, R0, c[1].y;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"ps_2_0
; 9 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
texld r0, t3, s1
texld r1, t0, s0
mov_pp r0.xyz, t2
dp3_pp r0.x, t1, r0
max_pp r0.x, r0, c1
mul_pp r0.x, r0, r0.w
mul_pp r1.xyz, r1, c0
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, r1
mov_pp oC0, r0
"
}

SubProgram "xbox360 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_MainTex] 2D
// Shader Timing Estimate, in Cycles/64 pixel vector:
// ALU: 8.00 (6 instructions), vertex: 0, texture: 8,
//   sequencer: 6, interpolator: 16;    4 GPRs, 48 threads,
// Performance (if enough threads): ~16 cycles per vector
// * Texture cycle estimates are assuming an 8bit/component texture with no
//     aniso or trilinear filtering.

"ps_360
backbbaaaaaaabdeaaaaaameaaaaaaaaaaaaaaceaaaaaanmaaaaabaeaaaaaaaa
aaaaaaaaaaaaaaleaaaaaabmaaaaaakippppadaaaaaaaaadaaaaaabmaaaaaaaa
aaaaaakbaaaaaafiaaacaaaaaaabaaaaaaaaaagiaaaaaaaaaaaaaahiaaadaaaa
aaabaaaaaaaaaaiiaaaaaaaaaaaaaajiaaadaaabaaabaaaaaaaaaaiiaaaaaaaa
fpemgjghgiheedgpgmgphcdaaaklklklaaabaaadaaabaaaeaaabaaaaaaaaaaaa
fpemgjghgihefegfhihehfhcgfdaaaklaaaeaaamaaabaaabaaabaaaaaaaaaaaa
fpengbgjgofegfhiaahahdfpddfpdaaadccodacodcdadddfddcodaaaaaaaaaaa
aaaaaaabaaaaaaaaaaaaaaaaaaaaaabeabpmaabaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaiebaaaadaaaaaaaaaeaaaaaaaaaaaaciieaaapaaap
aaaaaaabaaaadafaaaaahbfbaaaahcfcaaaaddfdaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafcaacaaaabcaameaaaaaa
aaaagaaeaaaaccaaaaaaaaaabaaibagbbpbpphppaaaaeaaababiaaabbpbppgii
aaaaeaaamiabaaabaaloloaapaabacaamiabaaacaagmgmaakcabppaaaaihabab
aamamablkbaaaaabmiadaaaaaabigmaaobabacaamiabiaaaaagmblaaobaaabaa
beigiaaaaamblbblobabaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"sce_fp_rsx // 12 instructions using 2 registers
[Configuration]
24
ffffffff0003c020000ffff9000000000000840002000000
[Offsets]
1
_LightColor0 1 0
000000a0
[Microcode]
192
ce800140c8011c9dc8000001c8003fe11e7e7d00c8001c9dc8000001c8000001
a2800540c8011c9dc9000001c8003fe19e021700c8011c9dc8000001c8003fe1
10800140c8041c9dc8000001c800000102800900c9001c9d00020000c8000001
00000000000000000000000000000000f0001702c8011c9dc8000001c8003fe1
1082024001001c9cc8000001c80000010e840240c8041c9dc8020001c8000001
000000000000000000000000000000000e810240ff041c9dc9081001c8000001
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 144 // 32 used size, 6 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedndbpbfdhapiilckikgmkblejejpngccfabaaaaaaimacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcieabaaaaeaaaaaaagbaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaadaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahbcaabaaa
aaaaaaaaagaabaaaaaaaaaaapgapbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaiocaabaaa
aaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_LightTexture0] 2D
"agal_ps
c1 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacadaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v3, s1 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaahacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, v2
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v1, r0.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa max r0.x, r0.x, c1
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 144 // 32 used size, 6 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedebicffpbhmhliedjegdkmmdakhnkceofabaaaaaaneadaaaaaeaaaaaa
daaaaaaaheabaaaaaaadaaaakaadaaaaebgpgodjdmabaaaadmabaaaaaaacpppp
aeabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaabaaaaacaaaaadiaaaaabllaecaaaaadaaaacpiaaaaaoeia
aaaioekaecaaaaadabaacpiaaaaaoelaabaioekaabaaaaacaaaaahiaabaaoela
aiaaaaadaaaacbiaaaaaoeiaacaaoelaafaaaaadaaaacciaaaaappiaaaaaaaia
fiaaaaaeaaaacbiaaaaaaaiaaaaaffiaabaaaakaacaaaaadaaaacbiaaaaaaaia
aaaaaaiaafaaaaadaaaacoiaabaabliaaaaablkaafaaaaadabaachiaaaaaaaia
aaaabliaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcieabaaaaeaaaaaaa
gbaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaadaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaa
pgapbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaa
agijcaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}

}
	}

#LINE 69


    } 

    FallBack "Diffuse"

}