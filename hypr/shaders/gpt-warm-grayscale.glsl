#version 300 es
precision highp float;

// Input texture coordinates (0.0 to 1.0)
in vec2 v_texcoord;

// The screen content texture
uniform sampler2D tex;

// The final color output
out vec4 fragColor;

// Warm, amber tint used to simulate "blue light reduction."
// R (1.0) is full, G (0.75) is high, and B (0.5) is significantly reduced.
// This creates a grayscale image with a strong yellow/orange tone.
const vec3 WARM_TINT = vec3(1.0, 0.75, 0.5);

void main() {
    // 1. Get the color of the pixel
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 2. Calculate the perceived brightness (Luma)
    // This removes the color information but retains contrast.
    vec3 lumaCoefficients = vec3(0.2126, 0.7152, 0.0722);
    float luma = dot(lumaCoefficients, color);

    // 3. Apply the warm tint to the luma value.
    // This makes the darkest parts dark and the brightest parts amber.
    vec3 adjustedColor = vec3(luma) * WARM_TINT;

    // 4. Output the result
    fragColor = vec4(adjustedColor, pixColor.a);
}
