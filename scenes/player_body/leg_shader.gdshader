shader_type canvas_item;

uniform bool choice = false;


void fragment() {
	vec2 uv = UV;
	float wave_h = 0.05; //擺幅
	float wave_w = 0.75; //波長
	float wave_s = 18.0; //波速
	if(choice == true){
		wave_s *= 1.0;
	}
	float wave = sin((TIME*wave_s+uv.x)/wave_w)*wave_h*(uv.x*2.0);
	uv.y += wave;
	COLOR = texture(TEXTURE, uv);
	if (UV.x <= 0.5){
		COLOR = vec4(0,0,0,0);
	}
}









