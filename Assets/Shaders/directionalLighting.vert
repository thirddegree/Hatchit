#version 440
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

out gl_PerVertex
{
    vec4 gl_Position;
};

//Instance Attributes
layout (location = 3) in vec4 color;
layout (location = 4) in vec3 direction;

//Output
layout (location = 0) out vec2 uv;
layout (location = 1) out vec4 lightColor;
layout (location = 2) out vec3 lightDirection;

void main() 
{
    uv.x = (gl_VertexIndex == 2) ? 2.0 : 0.0;
    uv.y = (gl_VertexIndex == 0) ? 2.0 : 0.0;

    lightColor = color;
    lightDirection = direction;

    gl_Position.x = (gl_VertexIndex == 2) ? 3.0 : -1.0;
    gl_Position.y = (gl_VertexIndex == 0) ? 3.0 : -1.0;
    gl_Position.zw = vec2(0.5,1);
}
