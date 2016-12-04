#version 330 core
layout (location = 0) in vec3 position;

out vec3 ourColor;
uniform float xOffset;
void main()
{
    gl_Position = vec4(position.x + xOffset, -position.y, position.z, 1.0f);
}
