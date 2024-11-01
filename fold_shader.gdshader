shader_type canvas_item;

uniform float flip_amount : hint_range(0, 1.0);

void vertex() {
    // Calculate the amount of "depth" effect based on x position relative to center
    float center_x = 0.0;
    
    // Scale the x position toward the center
    VERTEX.x = mix(VERTEX.x, center_x, flip_amount);
    
    // Calculate the y adjustment based on x position
    // Left of center gets amplified (moved up), right of center gets diminished (moved down)
    float y_adjustment = flip_amount * sign(VERTEX.x) * abs(VERTEX.x);
    
    VERTEX.y += y_adjustment;
	
	
}
void fragment() {
    // Sample the original color
    vec4 color = texture(TEXTURE, UV);
    
    // Darken the color based on flip_amount
    float darkness_factor = 1.0 - (0.5 * flip_amount);
    color.rgb *= darkness_factor;
    
    COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
