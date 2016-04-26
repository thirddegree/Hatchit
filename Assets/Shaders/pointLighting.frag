#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (set = 2, binding = 0) uniform sampler2D color;
layout (set = 2, binding = 1) uniform sampler2D position;
layout (set = 2, binding = 2) uniform sampler2D normal;

layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec4 clipPos;
layout (location = 1) in mat4 invViewProj;
layout (location = 5) in flat int width;
layout (location = 6) in flat int height;
layout (location = 7) in vec4 lightPos;
layout (location = 8) in float lightRadius;
layout (location = 9) in vec4 lightColor;
layout (location = 10) in vec3 lightAttenuation;

void main() 
{
    vec4 clipPos = clipPos / clipPos.w;
    float screenX = (clipPos.x + 1) * 0.5;
    float screenY = ((clipPos.y * -0.5) + 0.5);

    vec2 uv = vec2(screenX, screenY);

    vec4 color = texture(color, uv);
    vec4 positionSampled = texture(position, uv);
    vec4 normalSampled = texture(normal, uv);
    
    float depth = positionSampled.r;
    vec3 normal = normalSampled.xyz;

    //Depth to world space
    vec4 corner = vec4(1.35876, 2.41557, 100, 1);
    vec4 worldPos = vec4(clipPos.x, clipPos.y, -depth, 1);
    worldPos = worldPos * corner;
    worldPos = invViewProj * worldPos;
    worldPos = worldPos / worldPos.w;

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
