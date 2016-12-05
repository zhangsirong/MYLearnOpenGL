#version 330 core
out vec4 color;

in vec3 FragPos;  
in vec3 Normal;  
in vec3 LightPos;

uniform vec3 lightColor;
uniform vec3 objectColor;

void main()
{
    // 环境光照
    float ambientStrength = 0.1f;
    vec3 ambient = ambientStrength * lightColor;
  	
    // 漫反射光照
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(LightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    
    // 镜面光照
    float specularStrength = 0.5f;
    vec3 viewDir = normalize(- FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
    vec3 specular = specularStrength * spec * lightColor;
    
    vec3 result = (ambient + diffuse + specular) * objectColor;
    color = vec4(result, 1.0f);
}
