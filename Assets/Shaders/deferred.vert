#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

out gl_PerVertex{
    vec4 gl_Position;
};

layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 norm;
layout (location = 2) in vec2 uv;

layout (location = 3) in mat4 modelMatrix;

layout (location = 0) out float out_depth;
layout (location = 1) out vec3 out_norm;
layout (location = 2) out vec2 out_uv;

layout(push_constant) uniform Constants {
    mat4 proj;
    mat4 view;
} passConsts;


void main() 
{
    out_norm = mat3(modelMatrix) * norm;
    out_uv  = uv;
    
    vec4 depthPos = passConsts.view * modelMatrix * vec4(pos, 1);
    out_depth = depthPos.z / (100.0 - 1.0);

    vec4 clipPos = passConsts.proj * depthPos;
    
    gl_Position = clipPos;

    // GL->VK conventions
    gl_Position.y = -gl_Position.y;
    gl_Position.z = (gl_Position.z + gl_Position.w) / 2.0;
}
