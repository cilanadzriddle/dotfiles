#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 1. Calculate Luminance (Luma) to determine perceived brightness
    float luma = dot(color, vec3(0.2126, 0.7152, 0.0722));

    // 2. Adjust Contrast and Brightness
    // We use a high contrast factor to make the scene dramatic
    float contrastFactor = 1.6;
    luma = luma * contrastFactor - 0.3; // Increase contrast and slightly darken

    // 3. Apply the Blue/Cyan tint
    // We use a strong, defined blue color vector for the final output.
    // Darker areas will tend towards a deep blue/black, brighter areas towards cyan/white.
    vec3 blueTint = vec3(0.1, 0.4, 1.0); // R low, G medium, B high = Cyan/Blue mix

    // 4. Mix the luma with the blue tint
    // If the luma is low (dark areas), the color will be close to the tint's dark base.
    // If the luma is high (bright areas), it will approach white (full brightness).
    vec3 adjustedColor = blueTint * luma;

    // 5. Clamp the values and boost highlights for a digital glow
    adjustedColor = pow(adjustedColor, vec3(0.8)); // Brighten and enhance mid-tones
    adjustedColor = clamp(adjustedColor, 0.0, 1.0);

    fragColor = vec4(adjustedColor, pixColor.a);
}
