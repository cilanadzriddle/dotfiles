#version 300 es
precision highp float;

// Input texture coordinates (0.0 to 1.0)
in vec2 v_texcoord;

// The screen content texture
uniform sampler2D tex;

// The final color output
out vec4 fragColor;

// A professional, cooler blue duotone tint.
// We use a value slightly above 1.0 on Blue (1.2) for saturation,
// and reasonable values on G and R to avoid a harsh, pure-blue look.
const vec3 BLUE_TINT = vec3(0.5, 0.7, 1.2);

void main() {
    // 1. Get the color of the pixel
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 2. Calculate the perceived brightness (Luma)
    // Luma = 0.2126 * R + 0.7152 * G + 0.0722 * B
    vec3 lumaCoefficients = vec3(0.2126, 0.7152, 0.0722);
    float luma = dot(lumaCoefficients, color);

    // 3. Apply the blue tint to the luma value.
    vec3 adjustedColor = vec3(luma) * BLUE_TINT;

    // 4. Output the result
    fragColor = vec4(adjustedColor, pixColor.a);
}
