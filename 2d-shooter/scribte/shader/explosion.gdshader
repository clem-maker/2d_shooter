shader_type canvas_item;
uniform float alpha_value : hint_range(0.0, 1.0) = 1.0;
void fragment() {
	if (COLOR.a == 1.0){COLOR.a = alpha_value;}
}
