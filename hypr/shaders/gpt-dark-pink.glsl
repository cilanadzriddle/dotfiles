#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 1. Calculate Luminance (Luma) to determine perceived brightness.
    float luma = dot(color, vec3(0.2126, 0.7152, 0.0722));

    // 2. Adjust Luma for darkness (crushing the shadows and mid-tones).
    // Using pow(luma, 1.5) ensures dark areas become truly black.
    float adjustedLuma = pow(luma, 1.5); 

    // 3. Define the dark pink color coefficients.
    // High Red (1.0), Medium-Low Green (0.4), Medium Blue (0.6) = Deep Rose/Pink tint.
    vec3 pinkCoeffs = vec3(1.0, 0.4, 0.6); 

    // Multiply the adjusted brightness by the pink coefficients to create the final color.
    vec3 adjustedColor = adjustedLuma * pinkCoeffs;

    // 4. Clamp the values to the valid range [0.0, 1.0]
    adjustedColor = clamp(adjustedColor, 0.0, 1.0);

    // 5. Output the new color, preserving the original alpha (transparency)
    fragColor = vec4(adjustedColor, pixColor.a);
}
