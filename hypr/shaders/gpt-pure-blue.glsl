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

    // 2. Map the Luma to a pure monochromatic blue scale.
    // We use a slight power curve (0.95) to enhance mid-tone visibility.
    float adjustedLuma = pow(luma, 0.95);

    // The coefficients define the shade of blue:
    // Low Red (0.2) + Low Green (0.4) + High Blue (1.0) = A bright cyan-blue gradient.
    vec3 blueCoeffs = vec3(0.2, 0.4, 1.0); 

    // Multiply the adjusted brightness by the blue coefficients to create the final color.
    vec3 adjustedColor = adjustedLuma * blueCoeffs;

    // 3. Clamp the values to the valid range [0.0, 1.0]
    adjustedColor = clamp(adjustedColor, 0.0, 1.0);

    // 4. Output the new color, preserving the original alpha (transparency)
    fragColor = vec4(adjustedColor, pixColor.a);
}
