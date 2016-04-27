#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (set = 0, binding = 1) uniform sampler immutableSampler;
layout (set = 2, binding = 0) uniform texture2D frame;

layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec2 uv;

void main() 
{
    uFragColor = texture(sampler2D(frame, immutableSampler), uv);
}
