#version 300 es
precision highp float;

// Input texture coordinates (0.0 to 1.0), provided by the environment
in vec2 v_texcoord;

// The screen content texture (the image data we are modifying)
uniform sampler2D tex;

// The final color output of the shader
out vec4 fragColor;

void main() {
    // 1. Get the color of the pixel at the current texture coordinate
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 2. Calculate the perceived brightness (Luminance or Luma) of the color.
    // We use standard coefficients to reflect how humans perceive color brightness:
    // Luma = 0.2126 * R + 0.7152 * G + 0.0722 * B
    vec3 lumaCoefficients = vec3(0.2126, 0.7152, 0.0722);
    float luma = dot(lumaCoefficients, color);

    // 3. Create the new grayscale color vector, where R, G, and B are all equal to Luma
    vec3 adjustedColor = vec3(luma);

    // 4. Output the new color, preserving the original alpha (transparency)
    fragColor = vec4(adjustedColor, pixColor.a);
}
