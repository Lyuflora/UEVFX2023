#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    row_major float4x4 View_View_ViewToClip : packoffset(c32);
    row_major float4x4 View_View_SVPositionToTranslatedWorld : packoffset(c48);
    float3 View_View_ViewTilePosition : packoffset(c64);
    float3 View_View_ViewForward : packoffset(c66);
    float3 View_View_RelativePreViewTranslation : packoffset(c76);
    float View_View_PreExposure : packoffset(c136.z);
    float4 View_View_NormalOverrideParameter : packoffset(c139);
    float View_View_OutOfBoundsMask : packoffset(c141);
    float View_View_GameTime : packoffset(c143.y);
    float View_View_MaterialTextureMipBias : packoffset(c144);
};

cbuffer Primitive
{
    float3 Primitive_Primitive_TilePosition : packoffset(c1);
    float Primitive_Primitive_ObjectBoundsX : packoffset(c18.w);
    float4 Primitive_Primitive_ObjectRelativeWorldPositionAndRadius : packoffset(c19);
    float Primitive_Primitive_ObjectBoundsY : packoffset(c25.w);
    float Primitive_Primitive_ObjectBoundsZ : packoffset(c26.w);
};

cbuffer NiagaraSpriteVF
{
    uint NiagaraSpriteVF_NiagaraSpriteVF_MaterialParamValidMask : packoffset(c11.z);
};

cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[104] : packoffset(c0);
};

SamplerState View_MaterialTextureBilinearWrapedSampler;
SamplerState View_MaterialTextureBilinearClampedSampler;
Texture2D<float4> Material_Texture2D_0;
SamplerState Material_Texture2D_0Sampler;
Texture2D<float4> Material_Texture2D_1;
SamplerState Material_Texture2D_1Sampler;
Texture2D<float4> Material_Texture2D_2;
SamplerState Material_Texture2D_2Sampler;
Texture2D<float4> Material_Texture2D_3;
Texture2D<float4> Material_Texture2D_4;
SamplerState Material_Texture2D_4Sampler;
Texture2D<float4> Material_Texture2D_5;
SamplerState Material_Texture2D_5Sampler;
Texture2D<float4> Material_Texture2D_6;
Texture2D<float4> Material_Texture2D_7;
Texture2D<float4> Material_Texture2D_8;
SamplerState Material_Texture2D_8Sampler;
Texture2D<float4> Material_Texture2D_9;
SamplerState Material_Texture2D_9Sampler;
Texture2D<float4> Material_Texture2D_10;
SamplerState Material_Texture2D_10Sampler;
TextureCube<float4> Material_TextureCube_0;
SamplerState Material_TextureCube_0Sampler;

static float4 gl_FragCoord;
static float4 in_var_TEXCOORD10;
static float4 in_var_TEXCOORD11;
static float4 in_var_PARTICLE_DYNAMIC_PARAM0;
static float4 in_var_TEXCOORD0;
static float4 in_var_TEXCOORD1[1];
static float4 out_var_SV_Target0;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD10 : TEXCOORD10;
    float4 in_var_TEXCOORD11 : TEXCOORD11;
    nointerpolation float4 in_var_PARTICLE_DYNAMIC_PARAM0 : PARTICLE_DYNAMIC_PARAM0;
    float4 in_var_TEXCOORD0 : TEXCOORD0;
    float4 in_var_TEXCOORD1[1] : TEXCOORD1;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
};

void frag_main()
{
    float3x3 _202 = float3x3(in_var_TEXCOORD10.xyz, cross(in_var_TEXCOORD11.xyz, in_var_TEXCOORD10.xyz) * in_var_TEXCOORD11.w, in_var_TEXCOORD11.xyz);
    float4 _209 = mul(float4(gl_FragCoord.xyz, 1.0f), View_View_SVPositionToTranslatedWorld);
    float3 _213 = _209.xyz / _209.w.xxx;
    float3 _214 = _213 - View_View_RelativePreViewTranslation;
    float3 _223 = 0.0f.xxx;
    if (View_View_ViewToClip[3].w >= 1.0f)
    {
        _223 = -View_View_ViewForward;
    }
    else
    {
        _223 = normalize(-_213);
    }
    float3 _231 = normalize(mul(normalize((float3(0.0f, 0.0f, 1.0f) * View_View_NormalOverrideParameter.w) + View_View_NormalOverrideParameter.xyz), _202)) * 1.0f;
    float3 _236 = (-_223) + ((_231 * dot(_231, _223)) * 2.0f);
    float3 _241 = acos(Material_Material_PreshaderBuffer[3].w).xxx * 0.9998991489410400390625f.xxx;
    float _244 = _241.x;
    float3 _249 = float4(Material_Material_PreshaderBuffer[4].xyz, _244).xyz;
    float3 _251 = _249 * dot(_249, _236);
    float3 _252 = _236 - _251;
    float3 _274 = _223 - Material_Material_PreshaderBuffer[7].xyz;
    float2 _280 = _274.xy;
    float2 _281 = _280 * _280;
    float2 _287 = (-0.5f).xx + float2(frac(atan2(_274.y, _274.x) * 0.159154951572418212890625f), sqrt(_281.x + _281.y));
    float2 _297 = 0.5f.xx + float2(dot(_287, Material_Material_PreshaderBuffer[11].zw), dot(_287, Material_Material_PreshaderBuffer[12].xy));
    float _307 = fmod(View_View_GameTime, 4096.0f);
    float2 _312 = Material_Material_PreshaderBuffer[14].yz * (Material_Material_PreshaderBuffer[14].x * _307).xx;
    float2 _319 = (-0.5f).xx + _280;
    float2 _329 = 0.5f.xx + float2(dot(_319, Material_Material_PreshaderBuffer[18].zw), dot(_319, Material_Material_PreshaderBuffer[19].xy));
    float2 _341 = Material_Material_PreshaderBuffer[21].yz * (Material_Material_PreshaderBuffer[21].x * _307).xx;
    float _353 = (-1.0f) + View_View_MaterialTextureMipBias;
    float _371 = length(_274);
    float _387 = clamp((1.0f - (_371 * Material_Material_PreshaderBuffer[27].z)) * Material_Material_PreshaderBuffer[28].z, 0.0f, 1.0f);
    float3 _391 = Material_Texture2D_1.SampleLevel(Material_Texture2D_1Sampler, float2(((_297 * Material_Material_PreshaderBuffer[12].z.xx) + _312).x, ((_297 * Material_Material_PreshaderBuffer[14].w.xx) + _312).y) + (Material_Texture2D_0.SampleLevel(Material_Texture2D_0Sampler, float2(((_329 * Material_Material_PreshaderBuffer[19].z.xx) + _341).x, ((_329 * Material_Material_PreshaderBuffer[21].w.xx) + _341).y), _353).x * Material_Material_PreshaderBuffer[22].x).xx, _353).xyz * (clamp((1.0f - (_371 * Material_Material_PreshaderBuffer[26].x)) * Material_Material_PreshaderBuffer[27].x, 0.0f, 1.0f) - _387).xxx;
    float _394 = _391.x;
    float _398 = _391.y;
    float _402 = _391.z;
    float3 _426 = _223 - Material_Material_PreshaderBuffer[35].xyz;
    float _435 = clamp((1.0f - (length(_426) * Material_Material_PreshaderBuffer[37].z)) * Material_Material_PreshaderBuffer[38].z, 0.0f, 1.0f);
    float2 _443 = _426.xy;
    float2 _444 = _443 * _443;
    float2 _450 = (-0.5f).xx + float2(frac(atan2(_426.y, _426.x) * 0.159154951572418212890625f), sqrt(_444.x + _444.y));
    float2 _460 = 0.5f.xx + float2(dot(_450, Material_Material_PreshaderBuffer[42].zw), dot(_450, Material_Material_PreshaderBuffer[43].xy));
    float2 _463 = Material_Material_PreshaderBuffer[43].z.xx;
    float2 _472 = Material_Material_PreshaderBuffer[45].yz * (Material_Material_PreshaderBuffer[45].x * _307).xx;
    float2 _476 = Material_Material_PreshaderBuffer[45].w.xx;
    float3 _488 = Material_Texture2D_2.SampleLevel(Material_Texture2D_2Sampler, float2(((_460 * _463) + _472).x, ((_460 * _476) + _472).y), _353).xyz * _435.xxx;
    float3 _506 = Material_Material_PreshaderBuffer[48].x.xxx;
    float3 _510 = Material_Material_PreshaderBuffer[48].y.xxx;
    float3 _514 = Material_Material_PreshaderBuffer[48].z.xxx;
    float2 _523 = 0.5f.xx + float2(dot(_287, Material_Material_PreshaderBuffer[42].zw), dot(_287, Material_Material_PreshaderBuffer[43].xy));
    float3 _535 = Material_Texture2D_2.SampleLevel(Material_Texture2D_2Sampler, float2(((_523 * _463) + _472).x, ((_523 * _476) + _472).y), _353).xyz * _387.xxx;
    float3 _560 = Material_Material_PreshaderBuffer[54].xyz + (_223 * Material_Material_PreshaderBuffer[53].xyz);
    float _570 = abs(_223.x);
    float _572 = clamp(2.0f * _570, 0.0f, 1.0f);
    float _580 = 1.0f - clamp((_570 + (-0.5f)) * 2.0f, 0.0f, 1.0f);
    float _584 = 1.0f - ((_580 <= 0.0f) ? 0.0f : pow(_580, 16.0f));
    float _598 = abs(_223.z);
    float _600 = clamp(2.0f * _598, 0.0f, 1.0f);
    float _608 = 1.0f - clamp((_598 + (-0.5f)) * 2.0f, 0.0f, 1.0f);
    float _612 = 1.0f - ((_608 <= 0.0f) ? 0.0f : pow(_608, 16.0f));
    float2 _630 = 0.5f.xx + float2(dot(_319, Material_Material_PreshaderBuffer[58].zw), dot(_319, Material_Material_PreshaderBuffer[59].xy));
    float2 _642 = Material_Material_PreshaderBuffer[61].yz * (Material_Material_PreshaderBuffer[61].x * _307).xx;
    float4 _655 = Material_Texture2D_4.SampleBias(Material_Texture2D_4Sampler, float2(((_630 * Material_Material_PreshaderBuffer[59].z.xx) + _642).x, ((_630 * Material_Material_PreshaderBuffer[61].w.xx) + _642).y), View_View_MaterialTextureMipBias);
    float _656 = _655.x;
    float2 _676 = 0.5f.xx + float2(dot(_319, Material_Material_PreshaderBuffer[67].zw), dot(_319, Material_Material_PreshaderBuffer[68].xy));
    float2 _688 = Material_Material_PreshaderBuffer[70].yz * (Material_Material_PreshaderBuffer[70].x * _307).xx;
    float3 _706 = (lerp(float3((_535.x <= 0.0f) ? 0.0f : pow(_535.x, Material_Material_PreshaderBuffer[47].w), (_535.y <= 0.0f) ? 0.0f : pow(_535.y, Material_Material_PreshaderBuffer[47].w), (_535.z <= 0.0f) ? 0.0f : pow(_535.z, Material_Material_PreshaderBuffer[47].w)) * _506, _535 * _510, _514) * Material_Material_PreshaderBuffer[50].xyz) + (lerp(lerp(Material_Texture2D_3.Sample(View_MaterialTextureBilinearWrapedSampler, _560.xz).xyz, Material_Texture2D_3.Sample(View_MaterialTextureBilinearWrapedSampler, _560.yz).xyz, lerp(((_572 <= 0.0f) ? 0.0f : pow(_572, 16.0f)) * 0.5f, 0.5f + (_584 * 0.5f), clamp(_584 * 500.0f, 0.0f, 1.0f)).xxx), Material_Texture2D_3.Sample(View_MaterialTextureBilinearWrapedSampler, _560.xy).xyz, lerp(((_600 <= 0.0f) ? 0.0f : pow(_600, 16.0f)) * 0.5f, 0.5f + (_612 * 0.5f), clamp(_612 * 500.0f, 0.0f, 1.0f)).xxx) + ((((_656 <= 0.0f) ? 0.0f : pow(_656, Material_Material_PreshaderBuffer[63].x)).xxx * Material_Material_PreshaderBuffer[63].yzw) * Material_Texture2D_5.SampleBias(Material_Texture2D_5Sampler, float2(((_676 * Material_Material_PreshaderBuffer[68].z.xx) + _688).x, ((_676 * Material_Material_PreshaderBuffer[70].w.xx) + _688).y), View_View_MaterialTextureMipBias).x.xxx));
    float _714 = (View_View_GameTime * Material_Material_PreshaderBuffer[72].x) * 0.25f;
    float _715 = cos(_714);
    float _716 = sin(_714);
    float2 _728 = ((_280 * Material_Material_PreshaderBuffer[74].zw) + Material_Material_PreshaderBuffer[75].zw) - 0.5f.xx;
    float4 _736 = Material_Texture2D_6.SampleLevel(View_MaterialTextureBilinearClampedSampler, float2(dot(float2(_715, (-1.0f) * _716), _728), dot(float2(_716, _715), _728)) + 0.5f.xx, -1.0f);
    float3 _740 = Material_Material_PreshaderBuffer[76].x.xxx;
    float _753 = (View_View_GameTime * Material_Material_PreshaderBuffer[78].w) * 0.25f;
    float _754 = cos(_753);
    float _755 = sin(_753);
    float4 _765 = Material_Texture2D_7.SampleLevel(View_MaterialTextureBilinearClampedSampler, float2(dot(float2(_754, (-1.0f) * _755), _728), dot(float2(_755, _754), _728)) + 0.5f.xx, -1.0f);
    float3 _777 = ((lerp(float3((_394 <= 0.0f) ? 0.0f : pow(_394, Material_Material_PreshaderBuffer[30].w), (_398 <= 0.0f) ? 0.0f : pow(_398, Material_Material_PreshaderBuffer[30].w), (_402 <= 0.0f) ? 0.0f : pow(_402, Material_Material_PreshaderBuffer[30].w)) * Material_Material_PreshaderBuffer[31].x.xxx, _391 * Material_Material_PreshaderBuffer[31].y.xxx, Material_Material_PreshaderBuffer[31].z.xxx) * Material_Material_PreshaderBuffer[33].xyz) + ((1.0f - (_387 + _435)).xxx * ((lerp(float3((_488.x <= 0.0f) ? 0.0f : pow(_488.x, Material_Material_PreshaderBuffer[47].w), (_488.y <= 0.0f) ? 0.0f : pow(_488.y, Material_Material_PreshaderBuffer[47].w), (_488.z <= 0.0f) ? 0.0f : pow(_488.z, Material_Material_PreshaderBuffer[47].w)) * _506, _488 * _510, _514) * Material_Material_PreshaderBuffer[50].xyz) + _706))) + ((clamp((_736.xyz * _740) * _736.w.xxx, 0.0f.xxx, 1.0f.xxx) * Material_Material_PreshaderBuffer[78].xyz) + (clamp((_765.xyz * _740) * _765.w.xxx, 0.0f.xxx, 1.0f.xxx) * Material_Material_PreshaderBuffer[80].xyz));
    float3 _778 = mul(_202, _223);
    float _795 = lerp(Material_Material_PreshaderBuffer[82].z, Material_Material_PreshaderBuffer[82].y, clamp(abs(dot(_223, in_var_TEXCOORD11.xyz)), 0.0f, 1.0f));
    float _796 = floor(_795);
    float _797 = 1.0f / _795;
    float2 _799 = (Material_Material_PreshaderBuffer[82].x.xx * ((_778.xy * (-1.0f).xx) / _778.z.xx)) * _797.xx;
    float2 _800 = ddx(float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y));
    float2 _801 = ddy(float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y));
    float _805_copy;
    float2 _808 = 0.0f.xx;
    _808 = 0.0f.xx;
    float _806 = 0.0f;
    float2 _809 = 0.0f.xx;
    int _811 = 0;
    float _813 = 0.0f;
    float2 _832 = 0.0f.xx;
    float _805 = 1.0f;
    int _810 = 0;
    float _812 = 1.0f;
    float _814 = 1.0f;
    for (;;)
    {
        if (float(_810) < (_796 + 2.0f))
        {
            _813 = Material_Texture2D_8.SampleGrad(Material_Texture2D_8Sampler, float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) + _808, _800, _801).x;
            if (_805 < _813)
            {
                float _827 = _813 - _805;
                _832 = _808 - (_799 * (_827 / ((_814 - _812) + _827)));
                break;
            }
            _806 = _805 - _797;
            _809 = _808 + _799;
            _811 = _810 + 1;
            _805_copy = _805;
            _805 = _806;
            _808 = _809;
            _810 = _811;
            _812 = _813;
            _814 = _805_copy;
            continue;
        }
        else
        {
            _832 = _808;
            break;
        }
    }
    float2 _834 = float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) + _832.xy;
    float2 _837 = (-0.5f).xx + _834;
    float2 _847 = 0.5f.xx + float2(dot(_837, Material_Material_PreshaderBuffer[86].zw), dot(_837, Material_Material_PreshaderBuffer[87].xy));
    float2 _859 = Material_Material_PreshaderBuffer[89].yz * (Material_Material_PreshaderBuffer[89].x * _307).xx;
    float _875 = Material_Texture2D_8.Sample(View_MaterialTextureBilinearClampedSampler, _834).x * Material_Texture2D_9.SampleBias(Material_Texture2D_9Sampler, float2(((_847 * Material_Material_PreshaderBuffer[87].z.xx) + _859).x, ((_847 * Material_Material_PreshaderBuffer[89].w.xx) + _859).y), View_View_MaterialTextureMipBias).x;
    float4 _907 = Material_Texture2D_8.SampleBias(Material_Texture2D_8Sampler, float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y), View_View_MaterialTextureMipBias);
    float2 _913 = (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * 2.0f.xx) - 1.0f.xx;
    float2 _914 = _913 * _913;
    float2 _919 = (-0.5f).xx + float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y);
    float2 _929 = 0.5f.xx + float2(dot(_919, Material_Material_PreshaderBuffer[99].zw), dot(_919, Material_Material_PreshaderBuffer[100].xy));
    float2 _941 = Material_Material_PreshaderBuffer[102].yz * (Material_Material_PreshaderBuffer[102].x * _307).xx;
    bool4 _966 = ((NiagaraSpriteVF_NiagaraSpriteVF_MaterialParamValidMask & 1u) != 0u).xxxx;
    float _978 = clamp(in_var_TEXCOORD0.w * ((_907.y * Material_Material_PreshaderBuffer[95].w) * clamp((clamp(sqrt(_914.x + _914.y) + (Material_Texture2D_10.SampleBias(Material_Texture2D_10Sampler, float2(((_929 * Material_Material_PreshaderBuffer[100].z.xx) + _941).x, ((_929 * Material_Material_PreshaderBuffer[102].w.xx) + _941).y), View_View_MaterialTextureMipBias).x * Material_Material_PreshaderBuffer[103].x), 0.0f, 1.0f) * Material_Material_PreshaderBuffer[103].y) - lerp(Material_Material_PreshaderBuffer[103].y, -1.0f, float4(_966.x ? in_var_PARTICLE_DYNAMIC_PARAM0.x : 1.0f.xxxx.x, _966.y ? in_var_PARTICLE_DYNAMIC_PARAM0.y : 1.0f.xxxx.y, _966.z ? in_var_PARTICLE_DYNAMIC_PARAM0.z : 1.0f.xxxx.z, _966.w ? in_var_PARTICLE_DYNAMIC_PARAM0.w : 1.0f.xxxx.w).x * Material_Material_PreshaderBuffer[103].z), 0.0f, 1.0f)), 0.0f, 1.0f);
    float3 _979 = max(lerp(((Material_TextureCube_0.SampleLevel(Material_TextureCube_0Sampler, _251 + ((_252 * cos(_244)) + (cross(_249, _252) * sin(_244))), Material_Material_PreshaderBuffer[4].w).xyz * Material_Material_PreshaderBuffer[5].x.xxx) + (_777 + (lerp(((_875 <= 0.0f) ? 0.0f : pow(_875, Material_Material_PreshaderBuffer[91].w)) * Material_Material_PreshaderBuffer[92].x, _875 * Material_Material_PreshaderBuffer[92].y, Material_Material_PreshaderBuffer[92].z).xxx * Material_Material_PreshaderBuffer[94].xyz))) * in_var_TEXCOORD0.xyz, Material_Material_PreshaderBuffer[95].xyz, Material_Material_PreshaderBuffer[94].w.xxx), 0.0f.xxx);
    float _1030 = 0.0f;
    float3 _1031 = 0.0f.xxx;
    [branch]
    if (View_View_OutOfBoundsMask > 0.0f)
    {
        float3 _1001 = abs(((View_View_ViewTilePosition - Primitive_Primitive_TilePosition) * 2097152.0f) + (_214 - Primitive_Primitive_ObjectRelativeWorldPositionAndRadius.xyz));
        float3 _1002 = float3(Primitive_Primitive_ObjectBoundsX, Primitive_Primitive_ObjectBoundsY, Primitive_Primitive_ObjectBoundsZ) + 1.0f.xxx;
        bool _1004 = any(bool3(_1001.x > _1002.x, _1001.y > _1002.y, _1001.z > _1002.z));
        float3 _1028 = 0.0f.xxx;
        if (_1004)
        {
            float3 _1007 = View_View_ViewTilePosition * 0.57700002193450927734375f.xxx;
            float3 _1008 = _214 * 0.57700002193450927734375f.xxx;
            float3 _1024 = frac(frac(((_1007.x + _1007.y) + _1007.z) * 4194.30419921875f) + (((_1008.x + _1008.y) + _1008.z) * 0.00200000009499490261077880859375f)).xxx;
            _1028 = lerp(float3(1.0f, 1.0f, 0.0f), float3(0.0f, 1.0f, 1.0f), float3(bool3(_1024.x > 0.5f.xxx.x, _1024.y > 0.5f.xxx.y, _1024.z > 0.5f.xxx.z)));
        }
        else
        {
            _1028 = _979;
        }
        _1030 = _1004 ? 1.0f : _978;
        _1031 = _1028;
    }
    else
    {
        _1030 = _978;
        _1031 = _979;
    }
    float4 _1036 = float4(_1031 * 1.0f, _1030);
    float3 _1040 = _1036.xyz * View_View_PreExposure;
    out_var_SV_Target0 = float4(_1040.x, _1040.y, _1040.z, _1036.w);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD10 = stage_input.in_var_TEXCOORD10;
    in_var_TEXCOORD11 = stage_input.in_var_TEXCOORD11;
    in_var_PARTICLE_DYNAMIC_PARAM0 = stage_input.in_var_PARTICLE_DYNAMIC_PARAM0;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_TEXCOORD1 = stage_input.in_var_TEXCOORD1;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    return stage_output;
}
