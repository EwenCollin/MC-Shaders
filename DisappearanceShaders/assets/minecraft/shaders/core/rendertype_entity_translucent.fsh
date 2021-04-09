#version 150

#moj_import <fog.glsl>


//Disappearance settings
#define loopTime 5.0
#define ratio 0.33

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec4 overlayColor;
in vec2 texCoord0;
in vec4 normal;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
    if (color.a < 0.1) {
        discard;
    }
    color *= vertexColor * ColorModulator * vec4(1.0, 1.0, 1.0, (length(texCoord0)/(length(texCoord0) - clamp(mod(GameTime*200, loopTime) - (ratio*loopTime), 0.0, 1.0))) * pow(1 - clamp(mod(GameTime*200, loopTime) - (ratio*loopTime), 0.0, 1.0), 2));
    
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
    color *= lightMapColor;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
