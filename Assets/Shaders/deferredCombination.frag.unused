#version 400
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable
layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec2 in_uv;
layout (location = 1) in vec4 in_invViewProj;

layout (set = 1, binding = 1, location = 0) uniform sampler2D in_color;
layout (set = 1, binding = 1, location = 1) uniform sampler2D in_position;
layout (set = 1, binding = 1, location = 2) uniform sampler2D in_normal;

void main() 
{
    float nl = dot(in_norm, vec3(0,1,0));

    vec4 color =  texture(in_color, in_uv);
    float depth = texture(in_position, in_uv).r;
    vec3 normal = texture(in_normal, in_uv).rgb;

    uFragColor = color;
}
