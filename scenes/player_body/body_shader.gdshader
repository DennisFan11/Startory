shader_type canvas_item;

uniform float wave_h = 0.05; //擺幅
uniform float wave_w = 0.75; //波長
uniform float wave_s = 6.0; //波速

uniform vec2 center1 = vec2(0.6, 0.5);

vec2 rotation(vec2 v, float angle) {
	return (vec2(v.x*cos(angle), v.y*sin(angle) ));
	
}
void fragment() {
	vec2 center = rotation(center1, TIME*2.0);
	vec2 vector = vec2(UV - center);
	float distToCenter = length(vector);
	float angle = normalize(vector).x - normalize(vector).y;
	
	vec2 uv = UV;
	float wave = sin((TIME*wave_s+angle)/wave_w)*wave_h;
	uv += vec2(wave, wave)*vector;
	COLOR = texture(TEXTURE, uv);
}


