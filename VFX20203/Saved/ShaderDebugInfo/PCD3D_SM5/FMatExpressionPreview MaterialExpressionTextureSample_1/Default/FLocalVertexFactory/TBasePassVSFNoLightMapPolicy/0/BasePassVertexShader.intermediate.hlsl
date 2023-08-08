#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    row_major float4x4 View_View_TranslatedWorldToClip : packoffset(c0);
    float3 View_View_ViewTilePosition : packoffset(c64);
    float3 View_View_RelativePreViewTranslation : packoffset(c76);
    uint View_View_InstanceSceneDataSOAStride : packoffset(c283);
};

ByteAddressBuffer View_PrimitiveSceneData;
ByteAddressBuffer View_InstanceSceneData;
ByteAddressBuffer InstanceCulling_InstanceIdsBuffer;
cbuffer LocalVF
{
    int4 LocalVF_LocalVF_VertexFetch_Parameters : packoffset(c0);
};

Buffer<float4> LocalVF_VertexFetch_TexCoordBuffer;
Buffer<float4> LocalVF_VertexFetch_PackedTangentsBuffer;

static float4 gl_Position;
static int gl_VertexIndex;
static int gl_InstanceIndex;
static float4 in_var_ATTRIBUTE0;
static uint in_var_ATTRIBUTE13;
static float4 out_var_TEXCOORD10_centroid;
static float4 out_var_TEXCOORD11_centroid;
static float4 out_var_TEXCOORD0[1];
static uint out_var_PRIMITIVE_ID;

struct SPIRV_Cross_Input
{
    float4 in_var_ATTRIBUTE0 : ATTRIBUTE0;
    uint in_var_ATTRIBUTE13 : ATTRIBUTE13;
    uint gl_VertexIndex : SV_VertexID;
    uint gl_InstanceIndex : SV_InstanceID;
};

struct SPIRV_Cross_Output
{
    float4 out_var_TEXCOORD10_centroid : TEXCOORD10_centroid;
    float4 out_var_TEXCOORD11_centroid : TEXCOORD11_centroid;
    float4 out_var_TEXCOORD0[1] : TEXCOORD0;
    nointerpolation uint out_var_PRIMITIVE_ID : PRIMITIVE_ID;
    precise float4 gl_Position : SV_Position;
};

static float3x3 _97 = float3x3(0.0f.xxx, 0.0f.xxx, 0.0f.xxx);

void vert_main()
{
    float3 _109 = -View_View_ViewTilePosition;
    uint _128 = 0u;
    if ((in_var_ATTRIBUTE13 & 2147483648u) != 0u)
    {
        _128 = uint(int(asuint(asfloat(View_PrimitiveSceneData.Load4(((in_var_ATTRIBUTE13 & 2147483647u) * 42u) * 16 + 0)).y))) + uint(gl_InstanceIndex);
    }
    else
    {
        _128 = InstanceCulling_InstanceIdsBuffer.Load((in_var_ATTRIBUTE13 + uint(gl_InstanceIndex)) * 4 + 0) & 268435455u;
    }
    uint _134 = asuint(asfloat(View_InstanceSceneData.Load4(_128 * 16 + 0)).x);
    uint _136 = (_134 >> 0u) & 1048575u;
    float3 _251 = 0.0f.xxx;
    float4x4 _252 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
    float3 _253 = 0.0f.xxx;
    float _254 = 0.0f;
    [branch]
    if (false || (_136 != 1048575u))
    {
        uint4 _151 = asuint(asfloat(View_InstanceSceneData.Load4((View_View_InstanceSceneDataSOAStride + _128) * 16 + 0)));
        uint _153 = (2u * View_View_InstanceSceneDataSOAStride) + _128;
        float4x4 _157 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _157[3] = float4(asfloat(View_InstanceSceneData.Load4(_153 * 16 + 0)).x, asfloat(View_InstanceSceneData.Load4(_153 * 16 + 0)).y, asfloat(View_InstanceSceneData.Load4(_153 * 16 + 0)).z, 0.0f.xxxx.w);
        float4x4 _158 = _157;
        _158[3].w = 1.0f;
        uint _159 = _151.x;
        uint _166 = _151.y;
        float _169 = float((_166 >> 0u) & 32767u);
        float2 _173 = (float3(float((_159 >> 0u) & 65535u), float((_159 >> 16u) & 65535u), _169).xy - 32768.0f.xx) * 3.0518509447574615478515625e-05f;
        float _175 = (_169 - 16384.0f) * 4.3161006033187732100486755371094e-05f;
        bool _177 = (_166 & 32768u) != 0u;
        float _178 = _173.x;
        float _179 = _173.y;
        float _180 = _178 + _179;
        float _181 = _178 - _179;
        float3 _187 = normalize(float3(_180, _181, 2.0f - dot(1.0f.xx, abs(float2(_180, _181)))));
        float4 _188 = float4(_187.x, _187.y, _187.z, 0.0f.xxxx.w);
        float4x4 _189 = _158;
        _189[2] = _188;
        float _192 = 1.0f / (1.0f + _187.z);
        float _193 = _187.x;
        float _194 = -_193;
        float _195 = _187.y;
        float _197 = (_194 * _195) * _192;
        float _209 = sqrt(1.0f - (_175 * _175));
        float3 _214 = (float3(1.0f - ((_193 * _193) * _192), _197, _194) * (_177 ? _175 : _209)) + (float3(_197, 1.0f - ((_195 * _195) * _192), -_195) * (_177 ? _209 : _175));
        float4 _215 = float4(_214.x, _214.y, _214.z, 0.0f.xxxx.w);
        float4x4 _216 = _189;
        _216[0] = _215;
        float3 _219 = cross(_187.xyz, _214.xyz);
        float4 _220 = float4(_219.x, _219.y, _219.z, 0.0f.xxxx.w);
        float4x4 _221 = _216;
        _221[1] = _220;
        uint _222 = _151.w;
        uint _227 = _151.z;
        float3 _235 = (float3(uint3(_227 >> 0u, _227 >> 16u, _222 >> 0u) & uint3(65535u, 65535u, 65535u)) - 32768.0f.xxx) * asfloat(((_222 >> 16u) - 15u) << 23u);
        float4x4 _238 = _221;
        _238[0] = _215 * _235.x;
        float4x4 _241 = _238;
        _241[1] = _220 * _235.y;
        float4x4 _244 = _241;
        _244[2] = _188 * _235.z;
        _251 = 1.0f.xxx / abs(_235).xyz;
        _252 = _244;
        _253 = asfloat(View_PrimitiveSceneData.Load4(((_136 * 42u) + 1u) * 16 + 0)).xyz;
        _254 = ((((_134 >> 20u) & 4095u) & 1u) != 0u) ? (-1.0f) : 1.0f;
    }
    else
    {
        _251 = 0.0f.xxx;
        _252 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _253 = 0.0f.xxx;
        _254 = 0.0f;
    }
    uint _258 = uint(LocalVF_LocalVF_VertexFetch_Parameters.w) + uint(gl_VertexIndex);
    uint _259 = 2u * _258;
    float4 _264 = LocalVF_VertexFetch_PackedTangentsBuffer.Load(_259 + 1u);
    float _265 = _264.w;
    float3 _266 = _264.xyz;
    float3 _268 = cross(_266, LocalVF_VertexFetch_PackedTangentsBuffer.Load(_259).xyz) * _265;
    float3x3 _271 = _97;
    _271[0] = cross(_268, _266) * _265;
    float3x3 _272 = _271;
    _272[1] = _268;
    float3x3 _273 = _272;
    _273[2] = _266;
    float3x3 _283 = float3x3(_252[0].xyz, _252[1].xyz, _252[2].xyz);
    _283[0] = _252[0].xyz * _251.x;
    float3x3 _286 = _283;
    _286[1] = _252[1].xyz * _251.y;
    float3x3 _289 = _286;
    _289[2] = _252[2].xyz * _251.z;
    float3x3 _290 = mul(_273, _289);
    float3 _293 = in_var_ATTRIBUTE0.xxx * _252[0].xyz;
    float3 _295 = in_var_ATTRIBUTE0.yyy * _252[1].xyz;
    float3 _296 = _293 + _295;
    float3 _298 = in_var_ATTRIBUTE0.zzz * _252[2].xyz;
    float3 _299 = _296 + _298;
    float3 _302 = _253 + _109;
    float3 _303 = _252[3].xyz + View_View_RelativePreViewTranslation;
    float3 _304 = _302 * 2097152.0f;
    float3 _305 = _304 + _303;
    float3 _306 = _299 + _305;
    float _307 = _306.x;
    float _308 = _306.y;
    float _309 = _306.z;
    float4 _310 = float4(_307, _308, _309, 1.0f);
    uint _313 = uint(LocalVF_LocalVF_VertexFetch_Parameters.y);
    float4 _319 = LocalVF_VertexFetch_TexCoordBuffer.Load((_313 * _258) + min(0u, (_313 - 1u)));
    float4 _320 = float4(_310.x, _310.y, _310.z, _310.w);
    float4 _321 = mul(_320, View_View_TranslatedWorldToClip);
    float4 _333[1] = { float4(_319.x, _319.y, 0.0f.xxxx.z, 0.0f.xxxx.w) };
    out_var_TEXCOORD10_centroid = float4(_290[0], 0.0f);
    out_var_TEXCOORD11_centroid = float4(_290[2], _265 * _254);
    out_var_TEXCOORD0 = _333;
    out_var_PRIMITIVE_ID = _136;
    gl_Position = _321;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_VertexIndex = int(stage_input.gl_VertexIndex);
    gl_InstanceIndex = int(stage_input.gl_InstanceIndex);
    in_var_ATTRIBUTE0 = stage_input.in_var_ATTRIBUTE0;
    in_var_ATTRIBUTE13 = stage_input.in_var_ATTRIBUTE13;
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    stage_output.out_var_TEXCOORD10_centroid = out_var_TEXCOORD10_centroid;
    stage_output.out_var_TEXCOORD11_centroid = out_var_TEXCOORD11_centroid;
    stage_output.out_var_TEXCOORD0 = out_var_TEXCOORD0;
    stage_output.out_var_PRIMITIVE_ID = out_var_PRIMITIVE_ID;
    return stage_output;
}
