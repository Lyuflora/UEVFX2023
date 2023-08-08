#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    row_major float4x4 View_View_SVPositionToTranslatedWorld : packoffset(c48);
    float3 View_View_ViewTilePosition : packoffset(c64);
    float3 View_View_RelativePreViewTranslation : packoffset(c76);
    float View_View_PreExposure : packoffset(c136.z);
    float View_View_OutOfBoundsMask : packoffset(c141);
    float View_View_MaterialTextureMipBias : packoffset(c144);
};

ByteAddressBuffer View_PrimitiveSceneData;
Texture2D<float4> Material_Texture2D_0;
SamplerState Material_Texture2D_0Sampler;

static float4 gl_FragCoord;
static float4 in_var_TEXCOORD0[1];
static uint in_var_PRIMITIVE_ID;
static float4 out_var_SV_Target0;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD0[1] : TEXCOORD0;
    nointerpolation uint in_var_PRIMITIVE_ID : PRIMITIVE_ID;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
};

static float _65 = 0.0f;

void frag_main()
{
    float4 _86 = mul(float4(gl_FragCoord.xyz, 1.0f), View_View_SVPositionToTranslatedWorld);
    float3 _91 = (_86.xyz / _86.w.xxx) - View_View_RelativePreViewTranslation;
    float4 _97 = Material_Texture2D_0.SampleBias(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias);
    float4 _98 = max(_97, 0.0f.xxxx);
    float _99 = _98.x;
    float _103 = _98.y;
    float _107 = _98.z;
    float3 _113 = max(float4((_99 <= 0.0f) ? 0.0f : pow(_99, 0.454545438289642333984375f), (_103 <= 0.0f) ? 0.0f : pow(_103, 0.454545438289642333984375f), (_107 <= 0.0f) ? 0.0f : pow(_107, 0.454545438289642333984375f), _65).xyz, 0.0f.xxx);
    float3 _173 = 0.0f.xxx;
    [branch]
    if (View_View_OutOfBoundsMask > 0.0f)
    {
        uint _119 = in_var_PRIMITIVE_ID * 42u;
        float3 _145 = abs(((View_View_ViewTilePosition - asfloat(View_PrimitiveSceneData.Load4((_119 + 1u) * 16 + 0)).xyz) * 2097152.0f) + (_91 - asfloat(View_PrimitiveSceneData.Load4((_119 + 19u) * 16 + 0)).xyz));
        float3 _146 = float3(asfloat(View_PrimitiveSceneData.Load4((_119 + 18u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_119 + 25u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_119 + 26u) * 16 + 0)).w) + 1.0f.xxx;
        float3 _172 = 0.0f.xxx;
        if (any(bool3(_145.x > _146.x, _145.y > _146.y, _145.z > _146.z)))
        {
            float3 _151 = View_View_ViewTilePosition * 0.57700002193450927734375f.xxx;
            float3 _152 = _91 * 0.57700002193450927734375f.xxx;
            float3 _168 = frac(frac(((_151.x + _151.y) + _151.z) * 4194.30419921875f) + (((_152.x + _152.y) + _152.z) * 0.00200000009499490261077880859375f)).xxx;
            _172 = lerp(float3(1.0f, 1.0f, 0.0f), float3(0.0f, 1.0f, 1.0f), float3(bool3(_168.x > 0.5f.xxx.x, _168.y > 0.5f.xxx.y, _168.z > 0.5f.xxx.z)));
        }
        else
        {
            _172 = _113;
        }
        _173 = _172;
    }
    else
    {
        _173 = _113;
    }
    float4 _178 = float4(_173 * 1.0f, 1.0f);
    float3 _182 = _178.xyz * View_View_PreExposure;
    out_var_SV_Target0 = float4(_182.x, _182.y, _182.z, _178.w);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_PRIMITIVE_ID = stage_input.in_var_PRIMITIVE_ID;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    return stage_output;
}
