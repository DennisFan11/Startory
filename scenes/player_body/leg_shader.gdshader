shader_type canvas_item;

uniform float wave_h = 0.05; //擺幅
uniform float wave_w = 0.75; //波長
uniform float wave_s = 6.0; //波速

uniform bool choice = false;


void fragment() {
	vec2 uv = UV;
	float wave = sin((TIME*wave_s+uv.x)/wave_w)*wave_h*(uv.x*2.0);
	uv.y += wave;
	COLOR = texture(TEXTURE, uv);
	if (UV.x <= 0.5){
		COLOR = vec4(0,0,0,0);
	}
	if(choice == true){
		COLOR+=vec4(0.0,0.5,0.5,1.0);
	}
}









