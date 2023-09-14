shader_type canvas_item;

uniform float wave_h = 0.05; //擺幅
uniform float wave_w = 0.75; //波長
uniform float wave_s = 6.0; //波速
uniform vec2 center1 = vec2(0.6, 0.5);

uniform vec4 red = vec4(1,0.3,1,0.3);
uniform vec4 blue = vec4(0.3,1,1,0.3);
uniform float range = 0.02;

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
	
	if(texture(TEXTURE, uv).a == 0.0){
		float add_degree = PI/4.0*5.0;
		float min_degree = PI/4.0*9.0;
		vec2 uv_add = uv+vec2(cos(add_degree), sin(add_degree))*range;
		vec2 uv_min = uv+vec2(cos(min_degree), sin(min_degree))*range;
		COLOR = vec4(0,0,0,0);
		if(texture(TEXTURE, uv_add).a != 0.0){
			COLOR += blue;
		}
		if(texture(TEXTURE, uv_min).a != 0.0){
			COLOR += red;
		}
	}
		
	else{
		COLOR = texture(TEXTURE, uv);
	}
	COLOR = texture(TEXTURE, uv);
}