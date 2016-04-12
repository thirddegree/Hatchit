#version 450
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (location = 0) in  vec3 pos;
layout (location = 0) out vec2 uv;

void main() 
{
    uv.x = (gl_VertexIndex == 2) ? 2.0 : 0.0;
	uv.y = (gl_VertexIndex == 0) ? 2.0 : 0.0;

	gl_Position.x = (gl_VertexIndex == 2) ? 3.0 : -1.0;
	gl_Position.y = (gl_VertexIndex == 0) ? 3.0 : -1.0;
	gl_Position.zw = vec2(0.5,1);
}
