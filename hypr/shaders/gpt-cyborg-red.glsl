#version 300 es
precision highp float;

// Input texture coordinates (0.0 to 1.0)
in vec2 v_texcoord;

// The screen content texture
uniform sampler2D tex;

// The final color output
out vec4 fragColor;

// High-contrast, glowing red tint.
// The value of 1.5 on Red aggressively pushes the color toward pure red
// and increases its intensity (making it "glow" in highlights).
const vec3 CYBORG_RED_TINT = vec3(1.5, 0.1, 0.1);

void main() {
    // 1. Get the color of the pixel
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 2. Calculate the perceived brightness (Luma)
    // Luma = 0.2126 * R + 0.7152 * G + 0.0722 * B
    vec3 lumaCoefficients = vec3(0.2126, 0.7152, 0.0722);
    float luma = dot(lumaCoefficients, color);

    // 3. Apply the aggressive red tint to the luma value.
    vec3 adjustedColor = vec3(luma) * CYBORG_RED_TINT;

    // 4. Optionally, clamp the color to ensure it stays within the 0.0 to 1.0 range
    // (though Hyprland/MPV usually handles over-saturation gracefully).
    adjustedColor = clamp(adjustedColor, 0.0, 1.0);

    // 5. Output the result
    fragColor = vec4(adjustedColor, pixColor.a);
}
