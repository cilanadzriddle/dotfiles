#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 1. Desaturate the image slightly to prepare for color tinting.
    // This helps in giving a more uniform color wash.
    float luma = dot(color, vec3(0.2126, 0.7152, 0.0722));
    color = mix(color, vec3(luma), 0.3); // Adjust the mix factor for more/less desaturation

    // 2. Apply a strong magenta/red tint.
    // Adjusted to reduce green further and lower bias for a darker tone.
    color.r = pow(color.r, 0.8) * 1.25 + 0.05; // Slightly less aggressive red boost
    color.g = pow(color.g, 0.8) * 0.35;       // More heavily reduce green for deep magenta
    color.b = pow(color.b, 0.8) * 1.0 + 0.1; // Reduced blue bias to darken

    // 3. Further push towards the magenta/red dominant color.
    // Increased mix factor to pull the color closer to the dark dominant base.
    vec3 dominantColor = vec3(0.8, 0.1, 0.5); // A strong magenta/red base
    color = mix(color, dominantColor, 0.55); // Increased mix factor (0.4 -> 0.55)

    // 4. Add a bit of contrast and a slight "crush" for that grainy feel,
    // Increased power from 1.1 to 1.2 to deepen the shadows/darken the image.
    color = pow(color, vec3(1.2)); // Increase contrast and darkness
    color = mix(color, smoothstep(0.0, 1.0, color), 0.1); // Subtle posterization/crush

    // Ensure colors are within valid range
    color = clamp(color, 0.0, 1.0);

    fragColor = vec4(color, pixColor.a);
}
