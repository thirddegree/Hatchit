#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (set = 0, binding = 0) uniform sampler immutableSampler;
layout (set = 4, binding = 0) uniform texture2D color;
layout (set = 4, binding = 1) uniform texture2D position;
layout (set = 4, binding = 2) uniform texture2D normal;

layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec4 clipPos;
layout (location = 1) in vec4 depthPos;
layout (location = 2) in mat4 invView;
layout (location = 6) in flat int width;
layout (location = 7) in flat int height;
layout (location = 8) in vec4 lightPos;
layout (location = 9) in float lightRadius;
layout (location = 10) in vec4 lightColor;
layout (location = 11) in vec3 lightAttenuation;

void main() 
{
    vec4 clipPos = clipPos / clipPos.w;
    float screenX = (clipPos.x + 1) * 0.5;
    float screenY = ((clipPos.y * -0.5) + 0.5);

    vec2 uv = vec2(screenX, screenY);

    vec4 color = texture(sampler2D(color, immutableSampler), uv);
    vec4 positionSampled = texture(sampler2D(position, immutableSampler), uv);
    vec4 normalSampled = texture(sampler2D(normal, immutableSampler), uv);
    
    float depth = positionSampled.r;
    vec3 normal = normalSampled.xyz;

    //Depth to world space
    float farClipDistance = 100.0 - 1.0;
    vec3 viewRay = vec3(depthPos.xy * (farClipDistance / depthPos.z), farClipDistance);

    vec4 worldPos = vec4(viewRay * depth, 1);
    worldPos = invView * worldPos;

    //Convert normals from 0 to 1 to -1 to 1
    normal = normalize(normal * 2 - 1);
    
    //N*L
    vec3 lightDir = normalize(lightPos - worldPos).xyz;
    float nL = dot(normal, lightDir);

    //Calc attenuation
    float lightDist = length((lightPos - worldPos).xyz / lightRadius);
    float attenuation = clamp(1 / (
    (lightDist * lightDist * lightAttenuation.x) +
    (lightDist * lightAttenuation.y) + 
    lightAttenuation.z), 0.0f, 1.0f);

    uFragColor = nL * attenuation * lightColor;
}
