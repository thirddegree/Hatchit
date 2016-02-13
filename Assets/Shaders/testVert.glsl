#version 420

//Attributes
layout (location = 0) in vec3 vPosition;

uniform mat4 modelMat;
uniform mat4 viewMat;
uniform mat4 projMat;

void main()
{
	vec4 pos4 = vec4(vPosition, 1.0f);
	mat4 worlMat = projMat * viewMat * modelMat;

	gl_Position = worldMat * pos4;
}
