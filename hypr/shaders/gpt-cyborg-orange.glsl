#version 300 es
precision highp float;

// Input texture coordinates (0.0 to 1.0)
in vec2 v_texcoord;

// The screen content texture
uniform sampler2D tex;

// The final color output
out vec4 fragColor;

// High-contrast, glowing orange tint.
// R (1.5) provides high intensity and red dominance.
// G (0.8) ensures the color is orange, not pure red.
// B (0.1) suppresses blue for maximum contrast.
const vec3 CYBORG_ORANGE_TINT = vec3(1.5, 0.8, 0.1);

void main() {
    // 1. Get the color of the pixel
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 2. Calculate the perceived brightness (Luma).
    // This removes all original color information.
    vec3 lumaCoefficients = vec3(0.2126, 0.7152, 0.0722);
    float luma = dot(lumaCoefficients, color);

    // 3. Apply the aggressive orange tint to the luma value.
    vec3 adjustedColor = vec3(luma) * CYBORG_ORANGE_TINT;

    // 4. Clamp the color to ensure it stays visible on the screen.
    adjustedColor = clamp(adjustedColor, 0.0, 1.0);

    // 5. Output the result
    fragColor = vec4(adjustedColor, pixColor.a);
}
