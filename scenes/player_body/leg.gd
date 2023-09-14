@tool
extends Node2D
var angle = 0
var Out = 5
var In = 20
var curve1
var moving:bool = false
func _ready():
	curve1 = $leg_path.curve
	$leg_path/blood_meat.position = Vector2(0,0)
	$leg_path/blood_meat.points = curve1.get_baked_points()
	curve1.set_point_out(0,($out.position-$in.position).normalized()*Out)
func _process(delta):
	$leg_path/blood_meat.points = curve1.get_baked_points()
	curve1.set_point_position(0,$in.position)
	curve1.set_point_position(1,$out.position)
	curve1.set_point_position(2,Vector2($out.position.x,$out.position.y+20))
	var point
	if(angle == 1)or (angle == 3):
		point = Vector2(-20,-15)
	else:
		point = Vector2(20,-15)
	curve1.set_point_in(2,point)
