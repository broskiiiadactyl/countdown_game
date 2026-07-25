shader_type canvas_item;

// If you want to use a second, separate black-and-white texture as the mask:
uniform sampler2D mask_texture : hint_default_white;

void fragment() {
    // Get the base color from the TextureRect's normal texture
    vec4 base_color = texture(TEXTURE, UV);
    
    // Get the black and white mask value (using the red channel or average RGB)
    float mask_value = texture(mask_texture, UV).r;
    
    // Apply the mask value to the alpha channel
    COLOR = base_color;
    COLOR.a *= mask_value;
}