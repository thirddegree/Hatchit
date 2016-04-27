#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (location = 0) out vec4 out_color;
layout (location = 1) out float out_position;
layout (location = 2) out vec4 out_normal;

layout (location = 0) in float in_depth;
layout (location = 1) in vec3 in_norm;
layout (location = 2) in vec2 in_uv;

layout (set = 0, binding = 0) uniform sampler immutableSampler;
layout (set = 3, binding = 0) uniform texture2D color;

void main()
{
    vec4 textureColor = texture(sampler2D(color, immutableSampler), in_uv);

    out_color = textureColor;
    out_position = in_depth;
    out_normal = vec4(in_norm, 1);
}
