#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    row_major float4x4 View_View_RelativeWorldToClip : packoffset(c8);
    row_major float4x4 View_View_ViewToClip : packoffset(c32);
    row_major float4x4 View_View_SVPositionToTranslatedWorld : packoffset(c48);
    float3 View_View_ViewTilePosition : packoffset(c64);
    float3 View_View_MatrixTilePosition : packoffset(c65);
    float3 View_View_ViewForward : packoffset(c66);
    float4 View_View_InvDeviceZToWorldZTransform : packoffset(c71);
    float4 View_View_ScreenPositionScaleBias : packoffset(c72);
    float3 View_View_RelativePreViewTranslation : packoffset(c76);
    float4 View_View_ViewRectMin : packoffset(c128);
    float4 View_View_ViewSizeAndInvSize : packoffset(c129);
    float View_View_PreExposure : packoffset(c136.z);
    float View_View_OneOverPreExposure : packoffset(c136.w);
    float4 View_View_DiffuseOverrideParameter : packoffset(c137);
    float4 View_View_SpecularOverrideParameter : packoffset(c138);
    float4 View_View_NormalOverrideParameter : packoffset(c139);
    float View_View_OutOfBoundsMask : packoffset(c141);
    float View_View_UnlitViewmodeMask : packoffset(c146);
    float4 View_View_TranslucencyLightingVolumeMin[2] : packoffset(c149);
    float4 View_View_TranslucencyLightingVolumeInvSize[2] : packoffset(c151);
    float View_View_RenderingReflectionCaptureMask : packoffset(c183.w);
    float4 View_View_SkyLightColor : packoffset(c187);
    float3 View_View_VolumetricFogInvGridSize : packoffset(c229);
    float3 View_View_VolumetricFogGridZParams : packoffset(c230);
};

ByteAddressBuffer View_PrimitiveSceneData;
ByteAddressBuffer View_SkyIrradianceEnvironmentMap;
cbuffer TranslucentBasePass
{
    float TranslucentBasePass_TranslucentBasePass_Shared_Fog_ApplyVolumetricFog : packoffset(c118.w);
    float TranslucentBasePass_TranslucentBasePass_Shared_Fog_VolumetricFogStartDistance : packoffset(c119);
    uint TranslucentBasePass_TranslucentBasePass_Shared_UseBasePassSkylight : packoffset(c134);
    float3 TranslucentBasePass_TranslucentBasePass_TranslucencyGIGridZParams : packoffset(c197);
    int3 TranslucentBasePass_TranslucentBasePass_TranslucencyGIGridSize : packoffset(c198);
};

cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[4] : packoffset(c0);
};

SamplerState View_SharedBilinearClampedSampler;
Texture3D<float4> TranslucentBasePass_Shared_Fog_IntegratedLightScattering;
Texture2D<float4> TranslucentBasePass_SceneTextures_SceneDepthTexture;
SamplerState TranslucentBasePass_SceneTextures_PointClampSampler;
Texture3D<float4> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner;
Texture3D<float4> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter;
Texture3D<float4> TranslucentBasePass_TranslucencyGIVolumeHistory0;
SamplerState TranslucentBasePass_TranslucencyGIVolumeSampler;

static float4 gl_FragCoord;
static float4 in_var_TEXCOORD10_centroid;
static float4 in_var_TEXCOORD11_centroid;
static uint in_var_PRIMITIVE_ID;
static float4 in_var_TEXCOORD7;
static float4 out_var_SV_Target0;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD10_centroid : TEXCOORD10_centroid;
    float4 in_var_TEXCOORD11_centroid : TEXCOORD11_centroid;
    nointerpolation uint in_var_PRIMITIVE_ID : PRIMITIVE_ID;
    float4 in_var_TEXCOORD7 : TEXCOORD7;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
};

static float _111 = 0.0f;
static float3 _112 = 0.0f.xxx;

void frag_main()
{
    float3 _159 = -View_View_MatrixTilePosition;
    float4 _177 = float4((((gl_FragCoord.xy - View_View_ViewRectMin.xy) * View_View_ViewSizeAndInvSize.zw) - 0.5f.xx) * float2(2.0f, -2.0f), gl_FragCoord.z, 1.0f) * (1.0f / gl_FragCoord.w);
    float4 _181 = mul(float4(gl_FragCoord.xyz, 1.0f), View_View_SVPositionToTranslatedWorld);
    float3 _185 = _181.xyz / _181.w.xxx;
    float3 _186 = _185 - View_View_RelativePreViewTranslation;
    float3 _195 = 0.0f.xxx;
    if (View_View_ViewToClip[3].w >= 1.0f)
    {
        _195 = -View_View_ViewForward;
    }
    else
    {
        _195 = normalize(-_185);
    }
    float3 _203 = normalize(mul(normalize((float3(0.0f, 0.0f, 1.0f) * View_View_NormalOverrideParameter.w) + View_View_NormalOverrideParameter.xyz), float3x3(in_var_TEXCOORD10_centroid.xyz, cross(in_var_TEXCOORD11_centroid.xyz, in_var_TEXCOORD10_centroid.xyz) * in_var_TEXCOORD11_centroid.w, in_var_TEXCOORD11_centroid.xyz))) * 1.0f;
    float _208 = max(abs(1.0f - max(0.0f, dot(_203, _195))), 9.9999997473787516355514526367188e-05f);
    float _219 = (((_208 <= 0.0f) ? 0.0f : pow(_208, Material_Material_PreshaderBuffer[1].x)) * Material_Material_PreshaderBuffer[1].z) + Material_Material_PreshaderBuffer[1].y;
    float _252 = 0.0f;
    do
    {
        [flatten]
        if (View_View_ViewToClip[3u].w < 1.0f)
        {
            _252 = _177.w;
            break;
        }
        else
        {
            float _236 = _177.z;
            _252 = ((_236 * View_View_InvDeviceZToWorldZTransform.x) + View_View_InvDeviceZToWorldZTransform.y) + (1.0f / ((_236 * View_View_InvDeviceZToWorldZTransform.z) - View_View_InvDeviceZToWorldZTransform.w));
            break;
        }
    } while(false);
    float _254 = _177.w;
    float4 _264 = TranslucentBasePass_SceneTextures_SceneDepthTexture.SampleLevel(TranslucentBasePass_SceneTextures_PointClampSampler, ((_177.xy / _254.xx) * View_View_ScreenPositionScaleBias.xy) + View_View_ScreenPositionScaleBias.wz, 0.0f);
    float _265 = _264.x;
    float _286 = clamp(_219 * clamp(((((_265 * View_View_InvDeviceZToWorldZTransform.x) + View_View_InvDeviceZToWorldZTransform.y) + (1.0f / ((_265 * View_View_InvDeviceZToWorldZTransform.z) - View_View_InvDeviceZToWorldZTransform.w))) - _252) * Material_Material_PreshaderBuffer[3].y, 0.0f, 1.0f), 0.0f, 1.0f);
    float3 _296 = (0.039999999105930328369140625f.xxx * View_View_SpecularOverrideParameter.w) + View_View_SpecularOverrideParameter.xyz;
    bool _299 = View_View_RenderingReflectionCaptureMask != 0.0f;
    float3 _304 = 0.0f.xxx;
    if (_299)
    {
        _304 = View_View_DiffuseOverrideParameter.xyz + (_296 * 0.449999988079071044921875f);
    }
    else
    {
        _304 = View_View_DiffuseOverrideParameter.xyz;
    }
    bool3 _305 = _299.xxx;
    float3 _416 = 0.0f.xxx;
    if (TranslucentBasePass_TranslucentBasePass_TranslucencyGIGridSize.z > 0)
    {
        float4 _378 = mul(((float4(View_View_ViewTilePosition, 0.0f) + float4(_159, 0.0f)) * 2097152.0f) + float4(_186, 1.0f), View_View_RelativeWorldToClip);
        float _379 = _378.w;
        float4 _404 = TranslucentBasePass_TranslucencyGIVolumeHistory0.SampleLevel(TranslucentBasePass_TranslucencyGIVolumeSampler, float3(((_378.xy / _379.xx).xy * float2(0.5f, -0.5f)) + 0.5f.xx, (log2((_379 * TranslucentBasePass_TranslucentBasePass_TranslucencyGIGridZParams.x) + TranslucentBasePass_TranslucentBasePass_TranslucencyGIGridZParams.y) * TranslucentBasePass_TranslucentBasePass_TranslucencyGIGridZParams.z) / float(TranslucentBasePass_TranslucentBasePass_TranslucencyGIGridSize.z)), 0.0f);
        float3 _409 = _112;
        _409.x = _404.x * 0.886227548122406005859375f;
        float3 _411 = _409;
        _411.y = _404.y * 0.886227548122406005859375f;
        float3 _413 = _411;
        _413.z = _404.z * 0.886227548122406005859375f;
        _416 = max(0.0f.xxx, _413) * 0.3183098733425140380859375f.xxx;
    }
    else
    {
        float3 _362 = 0.0f.xxx;
        if (TranslucentBasePass_TranslucentBasePass_Shared_UseBasePassSkylight > 0u)
        {
            float _318 = _203.x;
            float _319 = _203.y;
            float4 _321 = float4(_318, _319, _203.z, 1.0f);
            float3 _325 = _112;
            _325.x = dot(asfloat(View_SkyIrradianceEnvironmentMap.Load4(0)), _321);
            float3 _329 = _325;
            _329.y = dot(asfloat(View_SkyIrradianceEnvironmentMap.Load4(16)), _321);
            float3 _333 = _329;
            _333.z = dot(asfloat(View_SkyIrradianceEnvironmentMap.Load4(32)), _321);
            float4 _336 = _321.xyzz * _321.yzzx;
            float3 _340 = _112;
            _340.x = dot(asfloat(View_SkyIrradianceEnvironmentMap.Load4(48)), _336);
            float3 _344 = _340;
            _344.y = dot(asfloat(View_SkyIrradianceEnvironmentMap.Load4(64)), _336);
            float3 _348 = _344;
            _348.z = dot(asfloat(View_SkyIrradianceEnvironmentMap.Load4(80)), _336);
            _362 = (max(0.0f.xxx, (_333 + _348) + (asfloat(View_SkyIrradianceEnvironmentMap.Load4(96)).xyz * ((_318 * _318) - (_319 * _319)))) * View_View_SkyLightColor.xyz) * 1.0f;
        }
        else
        {
            _362 = 0.0f.xxx;
        }
        _416 = _362;
    }
    bool _420 = TranslucentBasePass_TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0f;
    float4 _493 = 0.0f.xxxx;
    if (_420)
    {
        float4 _438 = mul(((float4(View_View_ViewTilePosition, 0.0f) + float4(_159, 0.0f)) * 2097152.0f) + float4(_186, 1.0f), View_View_RelativeWorldToClip);
        float _439 = _438.w;
        float4 _475 = 0.0f.xxxx;
        float _476 = 0.0f;
        if (_420)
        {
            float4 _469 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.SampleLevel(View_SharedBilinearClampedSampler, float3(((_438.xy / _439.xx).xy * float2(0.5f, -0.5f)) + 0.5f.xx, (log2((_439 * View_View_VolumetricFogGridZParams.x) + View_View_VolumetricFogGridZParams.y) * View_View_VolumetricFogGridZParams.z) * View_View_VolumetricFogInvGridSize.z), 0.0f);
            float3 _473 = _469.xyz * View_View_OneOverPreExposure;
            _475 = float4(_473.x, _473.y, _473.z, _469.w);
            _476 = TranslucentBasePass_TranslucentBasePass_Shared_Fog_VolumetricFogStartDistance;
        }
        else
        {
            _475 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            _476 = 0.0f;
        }
        float4 _481 = lerp(float4(0.0f, 0.0f, 0.0f, 1.0f), _475, clamp((_254 - _476) * 100000000.0f, 0.0f, 1.0f).xxxx);
        float _484 = _481.w;
        _493 = float4(_481.xyz + (in_var_TEXCOORD7.xyz * _484), _484 * in_var_TEXCOORD7.w);
    }
    else
    {
        _493 = in_var_TEXCOORD7;
    }
    float3 _501 = (_185 - View_View_TranslucencyLightingVolumeMin[0].xyz) * View_View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _514 = clamp((0.5f.xxx - abs(_501 - 0.5f.xxx)) * 6.0f, 0.0f.xxx, 1.0f.xxx);
    float4 _528 = lerp(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.SampleLevel(View_SharedBilinearClampedSampler, (_185 - View_View_TranslucencyLightingVolumeMin[1].xyz) * View_View_TranslucencyLightingVolumeInvSize[1].xyz, 0.0f), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.SampleLevel(View_SharedBilinearClampedSampler, _501, 0.0f), ((_514.x * _514.y) * _514.z).xxxx);
    float3 _544 = max(lerp(_219.xxx, Material_Material_PreshaderBuffer[2].xyz, Material_Material_PreshaderBuffer[1].w.xxx), 0.0f.xxx);
    float _605 = 0.0f;
    float3 _606 = 0.0f.xxx;
    [branch]
    if (View_View_OutOfBoundsMask > 0.0f)
    {
        uint _550 = in_var_PRIMITIVE_ID * 42u;
        float3 _576 = abs(((View_View_ViewTilePosition - asfloat(View_PrimitiveSceneData.Load4((_550 + 1u) * 16 + 0)).xyz) * 2097152.0f) + (_186 - asfloat(View_PrimitiveSceneData.Load4((_550 + 19u) * 16 + 0)).xyz));
        float3 _577 = float3(asfloat(View_PrimitiveSceneData.Load4((_550 + 18u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_550 + 25u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_550 + 26u) * 16 + 0)).w) + 1.0f.xxx;
        bool _579 = any(bool3(_576.x > _577.x, _576.y > _577.y, _576.z > _577.z));
        float3 _603 = 0.0f.xxx;
        if (_579)
        {
            float3 _582 = View_View_ViewTilePosition * 0.57700002193450927734375f.xxx;
            float3 _583 = _186 * 0.57700002193450927734375f.xxx;
            float3 _599 = frac(frac(((_582.x + _582.y) + _582.z) * 4194.30419921875f) + (((_583.x + _583.y) + _583.z) * 0.00200000009499490261077880859375f)).xxx;
            _603 = lerp(float3(1.0f, 1.0f, 0.0f), float3(0.0f, 1.0f, 1.0f), float3(bool3(_599.x > 0.5f.xxx.x, _599.y > 0.5f.xxx.y, _599.z > 0.5f.xxx.z)));
        }
        else
        {
            _603 = _544;
        }
        _605 = _579 ? 1.0f : _286;
        _606 = _603;
    }
    else
    {
        _605 = _286;
        _606 = _544;
    }
    float4 _616 = float4((((lerp(_304 * float4(_528.x * 0.886227548122406005859375f, _528.y * 0.886227548122406005859375f, _528.z * 0.886227548122406005859375f, _111).xyz, _304 + (float3(_305.x ? 0.0f.xxx.x : _296.x, _305.y ? 0.0f.xxx.y : _296.y, _305.z ? 0.0f.xxx.z : _296.z) * 0.449999988079071044921875f), View_View_UnlitViewmodeMask.xxx) + (_416 * _304)) + _606) * _493.w) + _493.xyz, _605);
    float3 _620 = _616.xyz * View_View_PreExposure;
    out_var_SV_Target0 = float4(_620.x, _620.y, _620.z, _616.w);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD10_centroid = stage_input.in_var_TEXCOORD10_centroid;
    in_var_TEXCOORD11_centroid = stage_input.in_var_TEXCOORD11_centroid;
    in_var_PRIMITIVE_ID = stage_input.in_var_PRIMITIVE_ID;
    in_var_TEXCOORD7 = stage_input.in_var_TEXCOORD7;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    return stage_output;
}
