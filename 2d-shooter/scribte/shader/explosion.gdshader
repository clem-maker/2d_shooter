shader_type canvas_item;

uniform float alpha_value : hint_range(0.0,1.0) = 1.0;
float fade_out(float value){
	return 0.25 * pow(4 , value);
}
void fragment() {
	if (COLOR.a == 1.0){
		COLOR.a = fade_out(alpha_value);
	}
}
