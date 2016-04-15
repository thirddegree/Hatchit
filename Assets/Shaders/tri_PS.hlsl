// Per-pixel color data passed through the pixel shader.
struct PixelShaderInput
{
    float4 pos : SV_POSITION;
    float3 normal : NORMAL0;
    float2 uv : TEXTURE0;
};

Texture2D diffuse : register(t1);
SamplerState samLinear : register(s0);

// A pass-through function for the (interpolated) color data.
float4 main(PixelShaderInput input) : SV_TARGET
{
    float nl = dot(input.normal, float3(0, 1, 0));

    float3 color = diffuse.Sample(samLinear, input.uv).xyz * nl;

    return float4(color, 1.0f);
}
