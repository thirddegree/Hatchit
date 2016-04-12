#version 450
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (set = 1, binding = 0) uniform sampler2D frame;

layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec2 uv;

void main() 
{
   uFragColor = texture(frame, uv);
}
