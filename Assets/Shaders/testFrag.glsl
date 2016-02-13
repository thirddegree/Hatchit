#version 420

out vec4 fragColor;

uniform vec4 color;

void main()
{
	fragColor = vec4(color, 1);
}
