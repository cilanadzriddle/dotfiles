#version 300 es
precision highp float;

// Input texture coordinates (0.0 to 1.0), provided by the environment
in vec2 v_texcoord;

// The screen content texture (the image data we are modifying)
uniform sampler2D tex;

// The final color output of the shader
out vec4 fragColor;

// Define a constant vector to tint the grayscale result.
// R is full (1.0), while G and B are significantly reduced (0.6 and 0.4)
// to push the color towards a deep, dominant red.
const vec3 RED_TINT = vec3(1.0, 0.6, 0.4);

void main() {
    // 1. Get the color of the pixel at the current texture coordinate
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    // 2. Calculate the perceived brightness (Luminance or Luma) of the color.
    // This value represents the overall grayscale level of the pixel.
    vec3 lumaCoefficients = vec3(0.2126, 0.7152, 0.0722);
    float luma = dot(lumaCoefficients, color);

    // 3. Create the new tinted color. We take the single 'luma' value,
    // convert it back to a grayscale vector (vec3(luma)), and then multiply
    // it by the RED_TINT vector. This keeps contrast but shifts the color.
    vec3 adjustedColor = vec3(luma) * RED_TINT;

    // 4. Output the new color, preserving the original alpha (transparency)
    fragColor = vec4(adjustedColor, pixColor.a);
}
