shader_type canvas_item;
uniform float A1 = 0.333333333; //縮放後
uniform float A2 = 0.333333333; //A=X, B=Y
uniform float B1 = 0.333333333;
uniform float B2 = 0.333333333;
uniform float scaleA2 = 2.0;
uniform float scaleB2 = 2.0;

void fragment() {
	vec2 uv = UV;
	float scaleA1 = A1/((1.0-(1.0-A1-A2)/scaleA2)*A1/(A1+A2));
	float scaleA3 = A2/((1.0-(1.0-A1-A2)/scaleA2)*A2/(A1+A2));
	float scaleB1 = B1/((1.0-(1.0-B1-B2)/scaleB2)*B1/(B1+B2));
	float scaleB3 = B2/((1.0-(1.0-B1-B2)/scaleB2)*B2/(B1+B2));
				//  X
	if (UV.x <= A1){
		uv.x /= scaleA1;
	}else{
		if (UV.x <= (1.0-A2)){
			uv.x -= A1;
			uv.x /= scaleA2;
			uv.x += A1/scaleA1;
		}else{
			uv.x -= (1.0-A2);
			uv.x /= scaleA3;
			uv.x += 1.0-A2/scaleA3;
		}
	}
				//  Y
	if (UV.y <= B1){
		uv.y /= scaleB1;
	}else{
		if (UV.y <= (1.0-B2)){
			uv.y -= B1;
			uv.y /= scaleB2;
			uv.y += B1/scaleB1;
		}else{
			uv.y -= (1.0-B2);
			uv.y /= scaleB3;
			uv.y += 1.0-B2/scaleB3;
		}
	}
	
	
	
	COLOR = texture(TEXTURE,uv);
}
