shader_type canvas_item;

uniform float flip_amount : hint_range(0.0, 1.0);

void vertex() {
    // Adjust the vertex position by interpolating towards the center (x = 0.0).
    // We scale the x component based on the flip_amount.

    // scale x-axis based on the flip amount
    VERTEX.x = mix(VERTEX.x, 0.0, flip_amount);
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
