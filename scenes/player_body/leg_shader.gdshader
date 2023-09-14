shader_type canvas_item;

uniform float wave_h = 0.05; //擺幅
uniform float wave_w = 0.75; //波長
uniform float wave_s = 6.0; //波速


void fragment() {
	vec2 uv = UV;
	float wave = sin((TIME*wave_s+uv.x)/wave_w)*wave_h*(uv.x*2.0);
	uv.y += wave;
	COLOR = texture(TEXTURE, uv);
	if (UV.x <= 0.4){
		COLOR = vec4(0,0,0,0);
	}
}









