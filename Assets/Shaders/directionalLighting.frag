#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (set = 0, binding = 0) uniform sampler immutableSampler;
layout (set = 4, binding = 2) uniform texture2D normal;

layout (location = 0) out vec4 uFragColor;

//Vertex Shader Input
layout (location = 0) in vec2 uv;
layout (location = 1) in vec4 lightColor;
layout (location = 2) in vec3 lightDirection;

void main() 
{
    vec4 normalSampled = texture(sampler2D(normal, immutableSampler), uv);

    vec3 normal = normalSampled.xyz;

    //Convert normals from 0 to 1 to -1 to 1
    normal = normalize(normal * 2 - 1);

    //N*L
    float nL = dot(normal, lightDirection);

    uFragColor = nL * lightColor;
}
