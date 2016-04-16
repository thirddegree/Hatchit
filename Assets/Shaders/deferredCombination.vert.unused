#version 400
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 norm;
layout (location = 2) in vec2 uv;

layout (location = 0) out vec2 out_uv;

layout(push_constant) uniform PassPushConsts {
	mat4 proj;
    mat4 view;
    mat4 invViewProj;
    int width;
    int height;
} passConsts;

layout(set = 1, binding = 0) uniform ObjectBuf {
    mat4 model;
} objectBuf;

void main() 
{
    out_norm = norm;
    out_uv  = uv;

    mat4 MVP =  passConsts.proj * (passConsts.view * objectBuf.model);

    vec4 worldPos = MVP * vec4(pos, 1);

    gl_Position = worldPos;

    // GL->VK conventions
    gl_Position.y = -gl_Position.y;
    gl_Position.z = (gl_Position.z + gl_Position.w) / 2.0;
}
