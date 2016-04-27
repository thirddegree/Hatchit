#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (set = 0, binding = 1) uniform sampler immutableSampler;
layout (set = 5, binding = 0) uniform texture2D color;
layout (set = 5, binding = 1) uniform texture2D lighting;

layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec2 uv;

void main() 
{
    vec4 sampledColor = texture(sampler2D(color, immutableSampler), uv);
    vec4 sampledLighting = texture(sampler2D(lighting, immutableSampler), uv);

    uFragColor = sampledColor * sampledLighting;
}
