extends Node2D
var angle = 0
var rot = false
var Out = 5
var In = 20
var curve1
var moving:bool = false
var using:bool = false
var choice:bool = false
var dmage = false
var charged = 0

func _ready():
	curve1 = $leg_path.curve
	$leg_path/blood_meat.position = Vector2(0,0)
	$leg_path/blood_meat.points = curve1.get_baked_points()
	curve1.set_point_out(0,($out.position-$in.position).normalized()*Out)
	
func _physics_process(delta):
	if angle == Global.choice:
		if Global.shooting == true:
			using = true
			dmage = false
			charged+=delta*2
	elif charged != 0:
		using = true
		dmage = true
		charged-=delta*2
		if charged<=0:
			charged = 0
	else:
		charged = 0
		using = false
		dmage = false
	
	
	
func _process(delta):
	$leg_path/blood_meat.points = curve1.get_baked_points()
	curve1.set_point_position(0,$in.position)
	curve1.set_point_position(1,$out.position)
	curve1.set_point_position(2,Vector2($out.position.x,$out.position.y+20))
	var point
	if(angle == 1)or (angle == 3):
		if rot == false:
			point = Vector2(-20,-15)
		else:
			point = Vector2(20,-15)
	else:
		if rot == false:
			point = Vector2(20,-15)
		else:
			point = Vector2(-20,-15)
			
	if angle == Global.choice:
		choice = true
		$leg_path/blood_meat.material.set_shader_parameter("choice",true)
		var text = $leg_path/blood_meat.material.get_shader_parameter("choice")
		$out/Label.text = str(text)
	else: 
		choice = false
		$leg_path/blood_meat.material.set_shader_parameter("choice",false)
		var text = $leg_path/blood_meat.material.get_shader_parameter("choice")
		$out/Label.text = str(text)
	curve1.set_point_in(2,point)
	
