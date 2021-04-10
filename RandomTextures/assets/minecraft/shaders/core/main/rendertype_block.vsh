#version 150

#moj_import <light.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform vec3 ChunkOffset;
uniform float GameTime;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec4 normal;


#define offset 5


void main() {
    //gl_Position = ProjMat * ModelViewMat * vec4(Position + ChunkOffset, 1.0);

    vertexDistance = length((ModelViewMat * vec4(Position + ChunkOffset, 1.0)).xyz);
    vertexColor = Color * minecraft_sample_lightmap(Sampler2, UV2);
    float time_offset_x = floor(mod(GameTime*50, 100));
    //float time_offset_y = floor(mod(GameTime*100, 1024)/32.0);
    texCoord0 = vec2(mod(UV0.x - (time_offset_x + offset)*16.0/1024.0, 0.5), mod(UV0.y - (time_offset_x + offset)*16.0/1024.0, 0.5));
    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);
    
    vec3 pos = Position + ChunkOffset;



    /*vec3 BH = vec3(8.0, 2.0, 0.0);
    float distanceToBH = length(BH - pos);
    pos = vec3(BH.x*exp(-distanceToBH) + pos.x*(1.0 - exp(-distanceToBH)),
    BH.y*exp(-distanceToBH) + pos.y*(1.0 - exp(-distanceToBH)),
    BH.z*exp(-distanceToBH) + pos.z*(1.0 - exp(-distanceToBH)));*/

    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1.0);
}
