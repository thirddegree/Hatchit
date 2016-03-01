#version 400
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable
layout (location = 0) out vec4 uFragColor;

layout (location = 0) in vec3 in_norm;
layout (location = 1) in vec2 in_uv;

void main() {

    float nl = dot(in_norm, vec3(0,1,0));

    vec3 color = vec3(1, 0, 0) * nl;

    uFragColor = vec4(color ,1);
}
