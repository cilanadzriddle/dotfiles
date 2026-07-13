#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 1. Calculate Luminance (Luma) to determine perceived brightness.
    // This value represents the grayscale brightness of the original pixel.
    float luma = dot(color, vec3(0.2126, 0.7152, 0.0722));

    // 2. Adjust Luma for darkness (crushing the shadows and mid-tones).
    // Raising Luma to the power of 1.5 significantly darkens the image.
    // The larger the number (e.g., 2.0), the darker and more contrasty the result.
    float adjustedLuma = pow(luma, 1.5); 

    // 3. Define the dark red color coefficients.
    // High Red (1.0), Low Green (0.2), Low Blue (0.2) = Deep Red/Maroon tint.
    vec3 redCoeffs = vec3(1.0, 0.2, 0.2); 

    // Multiply the adjusted brightness by the red coefficients to create the final color.
    // Dark areas (low adjustedLuma) will become black, bright areas will become deep red.
    vec3 adjustedColor = adjustedLuma * redCoeffs;

    // 4. Clamp the values to the valid range [0.0, 1.0]
    adjustedColor = clamp(adjustedColor, 0.0, 1.0);

    // 5. Output the new color, preserving the original alpha (transparency)
    fragColor = vec4(adjustedColor, pixColor.a);
}
