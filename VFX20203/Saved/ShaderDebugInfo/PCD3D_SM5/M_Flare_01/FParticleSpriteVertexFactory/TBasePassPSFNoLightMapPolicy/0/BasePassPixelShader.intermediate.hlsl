cbuffer View
{
    row_major float4x4 View_View_ViewToClip : packoffset(c28);
    row_major float4x4 View_View_SVPositionToTranslatedWorld : packoffset(c44);
    float3 View_View_ViewTilePosition : packoffset(c60);
    float4 View_View_InvDeviceZToWorldZTransform : packoffset(c67);
    float4 View_View_ScreenPositionScaleBias : packoffset(c68);
    float3 View_View_RelativePreViewTranslation : packoffset(c72);
    float4 View_View_ViewRectMin : packoffset(c124);
    float4 View_View_ViewSizeAndInvSize : packoffset(c125);
    float View_View_PreExposure : packoffset(c130.y);
    float View_View_OutOfBoundsMask : packoffset(c135);
    float View_View_MaterialTextureMipBias : packoffset(c138);
};

cbuffer Primitive
{
    float3 Primitive_Primitive_TilePosition : packoffset(c1);
    float Primitive_Primitive_ObjectBoundsX : packoffset(c18.w);
    float4 Primitive_Primitive_ObjectRelativeWorldPositionAndRadius : packoffset(c19);
    float Primitive_Primitive_ObjectBoundsY : packoffset(c25.w);
    float Primitive_Primitive_ObjectBoundsZ : packoffset(c26.w);
};

cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[12] : packoffset(c0);
};

Texture2D<float4> TranslucentBasePass_SceneTextures_SceneDepthTexture;
SamplerState TranslucentBasePass_SceneTextures_PointClampSampler;
Texture2D<float4> Material_Texture2D_0;
SamplerState Material_Texture2D_0Sampler;

static float4 gl_FragCoord;
static float4 in_var_TEXCOORD2;
static float4 in_var_TEXCOORD3[1];
static float4 out_var_SV_Target0;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD2 : TEXCOORD2;
    float4 in_var_TEXCOORD3[1] : TEXCOORD3;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
};

void frag_main()
{
    float4 _120 = float4((((gl_FragCoord.xy - View_View_ViewRectMin.xy) * View_View_ViewSizeAndInvSize.zw) - 0.5f.xx) * float2(2.0f, -2.0f), gl_FragCoord.z, 1.0f) * (1.0f / gl_FragCoord.w);
    float4 _124 = mul(float4(gl_FragCoord.xyz, 1.0f), View_View_SVPositionToTranslatedWorld);
    float3 _129 = (_124.xyz / _124.w.xxx) - View_View_RelativePreViewTranslation;
    float2 _130 = (-0.5f).xx + float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y);
    float4 _146 = Material_Texture2D_0.SampleBias(Material_Texture2D_0Sampler, 0.5f.xx + float2(dot(_130, Material_Material_PreshaderBuffer[3].yz), dot(_130, Material_Material_PreshaderBuffer[4].xy)), View_View_MaterialTextureMipBias);
    float _150 = _146.x;
    float _154 = _146.y;
    float _158 = _146.z;
    float3 _174 = lerp(float3((_150 <= 0.0f) ? 0.0f : pow(_150, Material_Material_PreshaderBuffer[6].w), (_154 <= 0.0f) ? 0.0f : pow(_154, Material_Material_PreshaderBuffer[6].w), (_158 <= 0.0f) ? 0.0f : pow(_158, Material_Material_PreshaderBuffer[6].w)) * Material_Material_PreshaderBuffer[7].x.xxx, _146.xyz * Material_Material_PreshaderBuffer[7].y.xxx, Material_Material_PreshaderBuffer[7].z.xxx);
    float _225 = 0.0f;
    do
    {
        [flatten]
        if (View_View_ViewToClip[3u].w < 1.0f)
        {
            _225 = _120.w;
            break;
        }
        else
        {
            float _209 = _120.z;
            _225 = ((_209 * View_View_InvDeviceZToWorldZTransform.x) + View_View_InvDeviceZToWorldZTransform.y) + (1.0f / ((_209 * View_View_InvDeviceZToWorldZTransform.z) - View_View_InvDeviceZToWorldZTransform.w));
            break;
        }
    } while(false);
    float4 _237 = TranslucentBasePass_SceneTextures_SceneDepthTexture.SampleLevel(TranslucentBasePass_SceneTextures_PointClampSampler, ((_120.xy / _120.w.xx) * View_View_ScreenPositionScaleBias.xy) + View_View_ScreenPositionScaleBias.wz, 0.0f);
    float _238 = _237.x;
    float _259 = clamp((in_var_TEXCOORD2.w * (_174 * Material_Material_PreshaderBuffer[10].w.xxx).x) * clamp(((((_238 * View_View_InvDeviceZToWorldZTransform.x) + View_View_InvDeviceZToWorldZTransform.y) + (1.0f / ((_238 * View_View_InvDeviceZToWorldZTransform.z) - View_View_InvDeviceZToWorldZTransform.w))) - _225) * Material_Material_PreshaderBuffer[11].z, 0.0f, 1.0f), 0.0f, 1.0f);
    float3 _260 = max(lerp((lerp(_174, dot(_174, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx, Material_Material_PreshaderBuffer[9].x.xxx) * Material_Material_PreshaderBuffer[9].y.xxx) * in_var_TEXCOORD2.xyz, Material_Material_PreshaderBuffer[10].xyz, Material_Material_PreshaderBuffer[9].z.xxx), 0.0f.xxx);
    float _309 = 0.0f;
    float3 _310 = 0.0f.xxx;
    [branch]
    if (View_View_OutOfBoundsMask > 0.0f)
    {
        float3 _282 = abs(((View_View_ViewTilePosition - Primitive_Primitive_TilePosition) * 2097152.0f) + (_129 - Primitive_Primitive_ObjectRelativeWorldPositionAndRadius.xyz));
        float3 _283 = float3(Primitive_Primitive_ObjectBoundsX, Primitive_Primitive_ObjectBoundsY, Primitive_Primitive_ObjectBoundsZ) + 1.0f.xxx;
        bool _285 = any(bool3(_282.x > _283.x, _282.y > _283.y, _282.z > _283.z));
        float3 _307 = 0.0f.xxx;
        if (_285)
        {
            float3 _303 = frac(frac(((View_View_ViewTilePosition.x + View_View_ViewTilePosition.y) + View_View_ViewTilePosition.z) * 2420.113525390625f) + (((_129.x + _129.y) + _129.z) * 0.001154000055976212024688720703125f)).xxx;
            _307 = lerp(float3(1.0f, 1.0f, 0.0f), float3(0.0f, 1.0f, 1.0f), float3(bool3(_303.x > 0.5f.xxx.x, _303.y > 0.5f.xxx.y, _303.z > 0.5f.xxx.z)));
        }
        else
        {
            _307 = _260;
        }
        _309 = _285 ? 1.0f : _259;
        _310 = _307;
    }
    else
    {
        _309 = _259;
        _310 = _260;
    }
    float4 _316 = float4((_310 * 1.0f) * _309, 0.0f);
    float3 _320 = _316.xyz * View_View_PreExposure;
    out_var_SV_Target0 = float4(_320.x, _320.y, _320.z, _316.w);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD2 = stage_input.in_var_TEXCOORD2;
    in_var_TEXCOORD3 = stage_input.in_var_TEXCOORD3;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    return stage_output;
}
