shader_type canvas_item;

uniform float wave_h = 0.05; //擺幅
uniform float wave_w = 0.75; //波長
uniform float wave_s = 6.0; //波速

uniform vec2 center = vec2(0.5, 0.5);


void fragment() {
	vec2 vector = vec2(UV - center);
	float distToCenter = length(vector);
	float angle = normalize(vector).x - normalize(vector).y;
	
	vec2 uv = UV;
	float wave = sin((TIME*wave_s+angle)/wave_w)*wave_h;
	uv += vec2(wave, wave)*vector;
	COLOR = texture(TEXTURE, uv);
}


