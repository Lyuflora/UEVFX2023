cbuffer View
{
    row_major float4x4 View_View_ViewToClip : packoffset(c28);
    row_major float4x4 View_View_SVPositionToTranslatedWorld : packoffset(c44);
    float3 View_View_ViewTilePosition : packoffset(c60);
    float3 View_View_ViewForward : packoffset(c62);
    float3 View_View_RelativePreViewTranslation : packoffset(c72);
    float4 View_View_BufferSizeAndInvSize : packoffset(c127);
    float View_View_PreExposure : packoffset(c130.y);
    float4 View_View_DiffuseOverrideParameter : packoffset(c131);
    float4 View_View_SpecularOverrideParameter : packoffset(c132);
    float4 View_View_NormalOverrideParameter : packoffset(c133);
    float2 View_View_RoughnessOverrideParameter : packoffset(c134);
    float View_View_OutOfBoundsMask : packoffset(c135);
    float View_View_MaterialTextureMipBias : packoffset(c138);
    float View_View_UnlitViewmodeMask : packoffset(c140);
    float3 View_View_PrecomputedIndirectLightingColorScale : packoffset(c154);
    float View_View_RenderingReflectionCaptureMask : packoffset(c178.w);
    float View_View_ShowDecalsMask : packoffset(c190.w);
    float View_View_bCheckerboardSubsurfaceProfileRendering : packoffset(c222);
    float3 View_View_VolumetricLightmapWorldToUVScale : packoffset(c226);
    float3 View_View_VolumetricLightmapWorldToUVAdd : packoffset(c227);
    float3 View_View_VolumetricLightmapIndirectionTextureSize : packoffset(c228);
    float View_View_VolumetricLightmapBrickSize : packoffset(c228.w);
    float3 View_View_VolumetricLightmapBrickTexelSize : packoffset(c229);
    float View_View_IndirectLightingCacheShowFlag : packoffset(c230);
};

ByteAddressBuffer View_PrimitiveSceneData;
cbuffer IndirectLightingCache
{
    float IndirectLightingCache_IndirectLightingCache_DirectionalLightShadowing : packoffset(c5);
    float4 IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients0[3] : packoffset(c6);
    float4 IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients1[3] : packoffset(c9);
    float4 IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients2 : packoffset(c12);
};

cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[7] : packoffset(c0);
};

Texture3D<uint4> View_VolumetricLightmapIndirectionTexture;
Texture3D<float4> View_DirectionalLightShadowingBrickTexture;
SamplerState View_SharedBilinearClampedSampler;
Texture2D<float4> OpaqueBasePass_DBufferATexture;
Texture2D<float4> OpaqueBasePass_DBufferBTexture;
Texture2D<float4> OpaqueBasePass_DBufferCTexture;
SamplerState OpaqueBasePass_DBufferATextureSampler;
Texture2D<float4> Material_Texture2D_0;
SamplerState Material_Texture2D_0Sampler;
Texture2D<float4> Material_Texture2D_1;
SamplerState Material_Texture2D_1Sampler;
Texture2D<float4> Material_Texture2D_2;
SamplerState Material_Texture2D_2Sampler;

static float4 gl_FragCoord;
static float4 in_var_TEXCOORD10_centroid;
static float4 in_var_TEXCOORD11_centroid;
static float4 in_var_TEXCOORD0[2];
static uint in_var_PRIMITIVE_ID;
static float4 out_var_SV_Target0;
static float4 out_var_SV_Target1;
static float4 out_var_SV_Target2;
static float4 out_var_SV_Target3;
static float4 out_var_SV_Target5;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD10_centroid : TEXCOORD10_centroid;
    float4 in_var_TEXCOORD11_centroid : TEXCOORD11_centroid;
    float4 in_var_TEXCOORD0[2] : TEXCOORD0;
    nointerpolation uint in_var_PRIMITIVE_ID : PRIMITIVE_ID;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
    float4 out_var_SV_Target1 : SV_Target1;
    float4 out_var_SV_Target2 : SV_Target2;
    float4 out_var_SV_Target3 : SV_Target3;
    float4 out_var_SV_Target5 : SV_Target5;
};

static float4 _162 = 0.0f.xxxx;
static float4 _167 = 0.0f.xxxx;

void frag_main()
{
    float3x3 _210 = float3x3(in_var_TEXCOORD10_centroid.xyz, cross(in_var_TEXCOORD11_centroid.xyz, in_var_TEXCOORD10_centroid.xyz) * in_var_TEXCOORD11_centroid.w, in_var_TEXCOORD11_centroid.xyz);
    float4 _215 = mul(float4(gl_FragCoord.xyz, 1.0f), View_View_SVPositionToTranslatedWorld);
    float3 _219 = _215.xyz / _215.w.xxx;
    float3 _220 = _219 - View_View_RelativePreViewTranslation;
    float3 _229 = 0.0f.xxx;
    if (View_View_ViewToClip[3].w >= 1.0f)
    {
        _229 = -View_View_ViewForward;
    }
    else
    {
        _229 = normalize(-_219);
    }
    float3 _234 = normalize(float3(in_var_TEXCOORD0[1].xyz));
    float _236 = _234.z + 1.0f;
    float3 _239 = float3(_234.xy, _236);
    float4 _245 = Material_Texture2D_0.SampleBias(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float2 _248 = (_245.xy * 2.0f.xx) - 1.0f.xx;
    float3 _260 = lerp(float4(_248, sqrt(clamp(1.0f - dot(_248, _248), 0.0f, 1.0f)), 1.0f).xyz, float3(0.0f, 0.0f, 1.0f), Material_Material_PreshaderBuffer[1].x.xxx);
    float3 _266 = float3(_260.xy * (-1.0f).xx, _260.z);
    float3 _272 = (_239 * dot(_239, _266).xxx) - (_236.xxx * _266);
    float3 _280 = normalize(mul(normalize((_272 * View_View_NormalOverrideParameter.w) + View_View_NormalOverrideParameter.xyz), _210)) * 1.0f;
    float4 _284 = Material_Texture2D_1.SampleBias(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float _290 = max(abs(1.0f - max(0.0f, dot(mul(_272, _210), _229))), 9.9999997473787516355514526367188e-05f);
    float _296 = _284.x;
    float4 _310 = Material_Texture2D_2.SampleBias(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float3 _327 = clamp(_310.xyz * Material_Material_PreshaderBuffer[4].xyz, 0.0f.xxx, 1.0f.xxx);
    float _328 = clamp(Material_Material_PreshaderBuffer[6].x * _296, 0.0f, 1.0f);
    float _329 = clamp(Material_Material_PreshaderBuffer[6].y * _284.z, 0.0f, 1.0f);
    float _334 = (clamp(Material_Material_PreshaderBuffer[6].z * _284.y, 0.0f, 1.0f) * View_View_RoughnessOverrideParameter.y) + View_View_RoughnessOverrideParameter.x;
    uint _335 = in_var_PRIMITIVE_ID * 40u;
    float _384 = 0.0f;
    float _385 = 0.0f;
    float _386 = 0.0f;
    float3 _387 = 0.0f.xxx;
    float3 _388 = 0.0f.xxx;
    [flatten]
    if (((asuint(asfloat(View_PrimitiveSceneData.Load4(_335 * 16 + 0)).x) & 8u) != 0u) && (View_View_ShowDecalsMask > 0.0f))
    {
        float2 _352 = gl_FragCoord.xy * View_View_BufferSizeAndInvSize.zw;
        float4 _356 = OpaqueBasePass_DBufferATexture.SampleLevel(OpaqueBasePass_DBufferATextureSampler, _352, 0.0f);
        float4 _359 = OpaqueBasePass_DBufferBTexture.SampleLevel(OpaqueBasePass_DBufferATextureSampler, _352, 0.0f);
        float4 _362 = OpaqueBasePass_DBufferCTexture.SampleLevel(OpaqueBasePass_DBufferATextureSampler, _352, 0.0f);
        float _372 = _362.w;
        _384 = (_334 * _372) + _362.z;
        _385 = (_329 * _372) + _362.y;
        _386 = (_328 * _372) + _362.x;
        _387 = (_327 * _356.w) + _356.xyz;
        _388 = normalize((_280 * _359.w) + ((_359.xyz * 2.0f) - 1.00392162799835205078125f.xxx));
    }
    else
    {
        _384 = _334;
        _385 = _329;
        _386 = _328;
        _387 = _327;
        _388 = _280;
    }
    uint _391 = asuint(asfloat(View_PrimitiveSceneData.Load4(_335 * 16 + 0)).x);
    bool _408 = View_View_IndirectLightingCacheShowFlag > 0.0f;
    float _414 = 0.0f;
    if (((asuint(asfloat(View_PrimitiveSceneData.Load4(_335 * 16 + 0)).x) & 2u) != 0u) && _408)
    {
        _414 = IndirectLightingCache_IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _414 = 1.0f;
    }
    float _465 = 0.0f;
    [branch]
    if ((asuint(asfloat(View_PrimitiveSceneData.Load4(_335 * 16 + 0)).x) & 4u) != 0u)
    {
        float3 _433 = clamp((((View_View_ViewTilePosition * 2097152.0f) + _220) * View_View_VolumetricLightmapWorldToUVScale) + View_View_VolumetricLightmapWorldToUVAdd, 0.0f.xxx, 0.9900000095367431640625f.xxx) * View_View_VolumetricLightmapIndirectionTextureSize;
        float4 _444 = float4(View_VolumetricLightmapIndirectionTexture.Load(int4(int4(int(_433.x), int(_433.y), int(_433.z), 0).xyz, 0)));
        _465 = View_DirectionalLightShadowingBrickTexture.SampleLevel(View_SharedBilinearClampedSampler, (((_444.xyz * (View_View_VolumetricLightmapBrickSize + 1.0f)) + (frac(_433 / _444.w.xxx) * View_View_VolumetricLightmapBrickSize)) + 0.5f.xxx) * View_View_VolumetricLightmapBrickTexelSize, 0.0f).x;
    }
    else
    {
        _465 = _414;
    }
    float3 _478 = ((_387 - (_387 * _386)) * View_View_DiffuseOverrideParameter.w) + View_View_DiffuseOverrideParameter.xyz;
    float3 _485 = (lerp((0.07999999821186065673828125f * _385).xxx, _387, _386.xxx) * View_View_SpecularOverrideParameter.w) + View_View_SpecularOverrideParameter.xyz;
    bool _488 = View_View_RenderingReflectionCaptureMask != 0.0f;
    float3 _493 = 0.0f.xxx;
    if (_488)
    {
        _493 = _478 + (_485 * 0.449999988079071044921875f);
    }
    else
    {
        _493 = _478;
    }
    bool3 _494 = _488.xxx;
    float3 _495 = float3(_494.x ? 0.0f.xxx.x : _485.x, _494.y ? 0.0f.xxx.y : _485.y, _494.z ? 0.0f.xxx.z : _485.z);
    float3 _497 = dot(_495, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx;
    float3 _583 = 0.0f.xxx;
    if (_408)
    {
        float4 _533 = _167;
        _533.y = (-0.48860299587249755859375f) * _388.y;
        float4 _536 = _533;
        _536.z = 0.48860299587249755859375f * _388.z;
        float4 _539 = _536;
        _539.w = (-0.48860299587249755859375f) * _388.x;
        float3 _540 = _388 * _388;
        float4 _543 = _162;
        _543.x = (1.09254801273345947265625f * _388.x) * _388.y;
        float4 _546 = _543;
        _546.y = ((-1.09254801273345947265625f) * _388.y) * _388.z;
        float4 _551 = _546;
        _551.z = 0.3153919875621795654296875f * ((3.0f * _540.z) - 1.0f);
        float4 _554 = _551;
        _554.w = ((-1.09254801273345947265625f) * _388.x) * _388.z;
        float4 _558 = _539;
        _558.x = 0.886227548122406005859375f;
        float3 _560 = _558.yzw * 2.094395160675048828125f;
        float4 _561 = float4(_558.x, _560.x, _560.y, _560.z);
        float4 _562 = _554 * 0.785398185253143310546875f;
        float _563 = (_540.x - _540.y) * 0.4290426075458526611328125f;
        float3 _569 = 0.0f.xxx;
        _569.x = (dot(IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients0[0], _561) + dot(IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients1[0], _562)) + (IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients2.x * _563);
        float3 _575 = _569;
        _575.y = (dot(IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients0[1], _561) + dot(IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients1[1], _562)) + (IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients2.y * _563);
        float3 _581 = _575;
        _581.z = (dot(IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients0[2], _561) + dot(IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients1[2], _562)) + (IndirectLightingCache_IndirectLightingCache_IndirectLightingSHCoefficients2.z * _563);
        _583 = max(0.0f.xxx, _581);
    }
    else
    {
        _583 = 0.0f.xxx;
    }
    float3 _586 = _583 * View_View_PrecomputedIndirectLightingColorScale;
    float3 _608 = max(lerp(((_296 * ((((_290 <= 0.0f) ? 0.0f : pow(_290, 5.0f)) * 0.959999978542327880859375f) + 0.039999999105930328369140625f)) * 10.0f).xxx, Material_Material_PreshaderBuffer[2].xyz, Material_Material_PreshaderBuffer[1].y.xxx), 0.0f.xxx);
    float3 _665 = 0.0f.xxx;
    [branch]
    if (View_View_OutOfBoundsMask > 0.0f)
    {
        float3 _639 = abs(((View_View_ViewTilePosition - asfloat(View_PrimitiveSceneData.Load4((_335 + 1u) * 16 + 0)).xyz) * 2097152.0f) + (_220 - asfloat(View_PrimitiveSceneData.Load4((_335 + 19u) * 16 + 0)).xyz));
        float3 _640 = float3(asfloat(View_PrimitiveSceneData.Load4((_335 + 18u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_335 + 25u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_335 + 26u) * 16 + 0)).w) + 1.0f.xxx;
        float3 _664 = 0.0f.xxx;
        if (any(bool3(_639.x > _640.x, _639.y > _640.y, _639.z > _640.z)))
        {
            float3 _660 = frac(frac(((View_View_ViewTilePosition.x + View_View_ViewTilePosition.y) + View_View_ViewTilePosition.z) * 2420.113525390625f) + (((_220.x + _220.y) + _220.z) * 0.001154000055976212024688720703125f)).xxx;
            _664 = lerp(float3(1.0f, 1.0f, 0.0f), float3(0.0f, 1.0f, 1.0f), float3(bool3(_660.x > 0.5f.xxx.x, _660.y > 0.5f.xxx.y, _660.z > 0.5f.xxx.z)));
        }
        else
        {
            _664 = _608;
        }
        _665 = _664;
    }
    else
    {
        _665 = _608;
    }
    float4 _672 = float4(((lerp(0.0f.xxx, _493 + (_495 * 0.449999988079071044921875f), View_View_UnlitViewmodeMask.xxx) + ((_586 * _493) * max(1.0f.xxx, ((((((_387 * 2.040400028228759765625f) - 0.3323999941349029541015625f.xxx) * 1.0f) + ((_387 * (-4.79510021209716796875f)) + 0.6417000293731689453125f.xxx)) * 1.0f) + ((_387 * 2.755199909210205078125f) + 0.69029998779296875f.xxx)) * 1.0f))) + _665) * 1.0f, 0.0f);
    float4 _679 = 0.0f.xxxx;
    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
    {
        float4 _678 = _672;
        _678.w = 0.0f;
        _679 = _678;
    }
    else
    {
        _679 = _672;
    }
    float2 _684 = (frac(gl_FragCoord.xy * 0.0078125f.xx) * 128.0f) + float2(-64.3406219482421875f, -72.4656219482421875f);
    float3 _702 = (_388 * 0.5f) + 0.5f.xxx;
    float4 _704 = 0.0f.xxxx;
    _704.x = _702.x;
    float4 _706 = _704;
    _706.y = _702.y;
    float4 _708 = _706;
    _708.z = _702.z;
    float4 _709 = _708;
    _709.w = ((2.0f * float((_391 & 128u) != 0u)) + float((_391 & 256u) != 0u)) * 0.3333333432674407958984375f;
    float4 _711 = 0.0f.xxxx;
    _711.x = _387.x;
    float4 _713 = _711;
    _713.y = _387.y;
    float4 _715 = _713;
    _715.z = _387.z;
    float4 _716 = _715;
    _716.w = ((log2(((dot(_586, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)) * max(1.0f.xxx, ((((((_497 * 2.040400028228759765625f) - 0.3323999941349029541015625f.xxx) * 1.0f) + ((_497 * (-4.79510021209716796875f)) + 0.6417000293731689453125f.xxx)) * 1.0f) + ((_497 * 2.755199909210205078125f) + 0.69029998779296875f.xxx)) * 1.0f).y) * View_View_PreExposure) + 0.00390625f) * 0.0625f) + 0.5f) + ((frac(dot(_684.xyx * _684.xyy, float3(20.390625f, 60.703125f, 2.4281208515167236328125f))) - 0.5f) * 0.0039215688593685626983642578125f);
    float4 _717 = 0.0f.xxxx;
    _717.x = _465;
    float4 _718 = _717;
    _718.y = 1.0f;
    float4 _719 = _718;
    _719.z = 1.0f;
    float4 _720 = _719;
    _720.w = 1.0f;
    out_var_SV_Target0 = _679 * View_View_PreExposure;
    out_var_SV_Target1 = _709;
    out_var_SV_Target2 = float4(_386, _385, _384, 0.507843196392059326171875f);
    out_var_SV_Target3 = _716;
    out_var_SV_Target5 = _720;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD10_centroid = stage_input.in_var_TEXCOORD10_centroid;
    in_var_TEXCOORD11_centroid = stage_input.in_var_TEXCOORD11_centroid;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_PRIMITIVE_ID = stage_input.in_var_PRIMITIVE_ID;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    stage_output.out_var_SV_Target1 = out_var_SV_Target1;
    stage_output.out_var_SV_Target2 = out_var_SV_Target2;
    stage_output.out_var_SV_Target3 = out_var_SV_Target3;
    stage_output.out_var_SV_Target5 = out_var_SV_Target5;
    return stage_output;
}
