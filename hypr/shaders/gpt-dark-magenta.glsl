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
    // Using pow(luma, 1.5) ensures dark areas become truly black, and mid-tones are pulled down.
    float adjustedLuma = pow(luma, 1.5); 

    // 3. Define the dark magenta color coefficients.
    // High Red (1.0), Very Low Green (0.1), High Blue (0.8) = Deep Magenta tint.
    vec3 magentaCoeffs = vec3(1.0, 0.1, 0.8); 

    // Multiply the adjusted brightness by the magenta coefficients to create the final color.
    vec3 adjustedColor = adjustedLuma * magentaCoeffs;

    // 4. Clamp the values to the valid range [0.0, 1.0]
    adjustedColor = clamp(adjustedColor, 0.0, 1.0);

    // 5. Output the new color, preserving the original alpha (transparency)
    fragColor = vec4(adjustedColor, pixColor.a);
}
