#version 450
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (set = 2, binding = 1) uniform sampler2D color;
layout (set = 2, binding = 2) uniform sampler2D position;
layout (set = 2, binding = 3) uniform sampler2D normal;

layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec2 uv;

void main() 
{
   uFragColor = texture(color, uv);
}
