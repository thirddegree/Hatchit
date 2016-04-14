#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (set = 2, binding = 0) uniform sampler2D color;
layout (set = 2, binding = 1) uniform sampler2D position;
layout (set = 2, binding = 2) uniform sampler2D normal;

layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec2 uv;

void main() 
{
    vec4 color = texture(color, uv);
    vec4 positionSampled = texture(position, uv);
    vec4 normalSampled = texture(normal, uv);

    float depth = positionSampled.r;
    vec3 normal = normalSampled.xyz;

    vec4 ambientLight = vec4(0.4f, 0.4f, 0.4f, 1.0f);
    float nL = dot(normal, vec3(0, 1, 0));
    vec4 dirLight = vec4(nL, nL, nL, 1.0f);

    vec4 fragColor = clamp(color * (dirLight * (1 - depth * 0.5f) + ambientLight * (1 - depth * 2)), 0.0f, 1.0f);
    fragColor.w = 1;

    uFragColor = fragColor;
}
