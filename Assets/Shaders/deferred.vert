#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

out gl_PerVertex{
    vec4 gl_Position;
};

struct InstanceData{
    mat4 worldMatrix;
};

layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 norm;
layout (location = 2) in vec2 uv;

layout (location = 0) out float out_depth;
layout (location = 1) out vec3 out_norm;
layout (location = 2) out vec2 out_uv;

layout(push_constant) uniform PassPushConsts {
	mat4 proj;
    mat4 view;
} passConsts;

layout(set = 0, binding = 0) uniform ObjectBuf {
    mat4 model;
} objectBuf;

layout(set = 3, binding = 0) uniform samplerBuffer InstanceDataBuffer;

void main() 
{
    vec4 depthPos = vec4(pos, 1) + vec4(gl_InstanceIndex, 0, 0, 0);
    depthPos = objectBuf.model * depthPos;
    depthPos = passConsts.view * depthPos;

    
    out_norm = norm;
    out_uv  = uv;
    
    vec4 worldPos = passConsts.proj * depthPos;
    
    out_depth = worldPos.z / 100.0f;
    
    gl_Position = worldPos;

    // GL->VK conventions
    gl_Position.y = -gl_Position.y;
    gl_Position.z = (gl_Position.z + gl_Position.w) / 2.0;
}
