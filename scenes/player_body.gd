@tool
extends Node2D



func _ready():
	_leg_setting()
	
func _leg_setting():
	var origin:Vector2 = $body/leg.position #右下
	$body/leg2.scale = $body/leg.scale
	$body/leg3.scale = $body/leg.scale
	$body/leg4.scale = $body/leg.scale
	
	$body/leg2.position = Vector2(origin.x*-1,origin.y) #左下
	$body/leg2.scale.x *=-1
	$body/leg3.position = Vector2(origin.x,origin.y*-1) #右上
	$body/leg3.scale.y *=-1
	$body/leg4.position = Vector2(origin.x*-1,origin.y*-1)#左上
	$body/leg4.scale *=-1
	
	$body/leg3.curve.set_point_position(1, Vector2(30.875, 29.96))

func _physics_process(delta):
	if not Engine.is_editor_hint():
		var max
		var speed
		if Global.running == true:
			max = Global.max_run_speed
			speed = Global.run_speed
		else:
			max = Global.max_speed
			speed = Global.speed
		var vec = Global.move_vector * (speed + Global.damp)
		if ($body.linear_velocity + vec).length() <= max:
			$body.apply_central_impulse(vec)
		Global.player_position=$body.position
	
