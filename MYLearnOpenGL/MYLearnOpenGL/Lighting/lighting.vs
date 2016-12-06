#version 330 core
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;


out vec3 LightingColor;

uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 lightColor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{
    gl_Position = projection * view *  model * vec4(position, 1.0f);
    
    vec3 Position = vec3(model * vec4(position, 1.0f));
    vec3 Normal = mat3(transpose(inverse(model))) * normal;
    
    // 环境光照
    float ambientStrength = 0.1f;
    vec3 ambient = ambientStrength * lightColor;
    
    // 漫反射光照
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(lightPos - Position);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    
    // 镜面光照
    float specularStrength = 1.0f;
    vec3 viewDir = normalize(viewPos - Position);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
    vec3 specular = specularStrength * spec * lightColor;
    
    LightingColor = ambient + diffuse + specular;
}
