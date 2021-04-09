#version 150

//Cartoon settings
#define saturationFactor 4.0
#define averageTextures 1

vec4 average_16x(sampler2D sampler, vec2 tile) {
    ivec2 start = ivec2(tile * 64.0) * 16;

    vec4 accum = vec4(0.0);
    float div = 0.0;
    for (int xx = 0; xx < 16; ++xx) {
        for (int yy = 0; yy < 16; ++yy) {
            vec4 colour = texelFetch(sampler, start + ivec2(xx, yy), 0);
            if (colour.a > 0.0) {
                accum += colour;
                div += 1.0;
            }
        }
    }
    if (div == 0.0) {
        return accum;
    }
    return accum / div;
}

vec3 saturation(vec3 rgb, float adjustment)
{
    const vec3 W = vec3(0.2125, 0.7154, 0.0721);
    vec3 intensity = vec3(dot(rgb, W));
    return mix(intensity, rgb, adjustment);
}
