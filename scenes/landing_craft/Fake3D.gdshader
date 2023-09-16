shader_type canvas_item;
uniform float A1 = 0.3; //縮放前
uniform float A2 = 0.3; //A=X, B=Y
uniform float B1 = 0.3; //縮放前
uniform float B2 = 0.3; //A=X, B=Y
uniform float dist  = 0.0;
uniform float angle = 0.0;


void fragment() {
	vec2 uv = UV;
	float r1 = 1.0+(-1.0*cos(angle)*dist);
	float r3 = 1.0+(1.0*cos(angle)*dist);
	float r2 = (1.0-A1*r1-A2*r3)/(1.0-A1-A2);
	if (UV.x <= A1*r1){
		uv.x /= r1;
	}else{
		if (UV.x >= 1.0-(A2*r3)){
			uv.x -= (1.0-(A2*r3));
			uv.x /= r3;
			uv.x += (1.0-A2);
		}else{
			uv.x -= A1*r1;
			uv.x /= r2;
			uv.x += A1;
		}
	}
	float r1b = 1.0+(-1.0*sin(angle)*dist);
	float r3b = 1.0+(1.0*sin(angle)*dist);
	float r2b = (1.0-A1*r1-A2*r3)/(1.0-A1-A2);
	if (UV.y <= B1*r1b){
		uv.y /= r1b;
	}else{
		if (UV.y >= 1.0-(B2*r3b)){
			uv.y -= (1.0-(B2*r3b));
			uv.y /= r3b;
			uv.y += (1.0-B2);
		}else{
			uv.y -= B1*r1b;
			uv.y /= r2b;
			uv.y += B1;
		}
	}
	
	
	
	COLOR = texture(TEXTURE,uv);
}
