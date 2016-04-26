#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (set = 4, binding = 0) uniform sampler2D color;
layout (set = 4, binding = 1) uniform sampler2D lighting;

layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec2 uv;

void main() 
{
    vec4 sampledColor = texture(color, uv);
    vec4 sampledLighting = texture(lighting, uv);

    uFragColor = sampledColor * sampledLighting;
}
