#version 400
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (location = 0) out vec4 out_color;
layout (location = 1) out float out_position;
layout (location = 2) out vec4 out_normal;

layout (location = 0) in float in_depth;
layout (location = 1) in vec3 in_norm;
layout (location = 2) in vec2 in_uv;

layout (set = 1, binding = 1) uniform sampler2D color;

void main()
{
    vec4 textureColor = texture(color, in_uv);

    out_color = textureColor;
    out_position = in_depth;
    out_normal = vec4(in_norm, 1);
}
