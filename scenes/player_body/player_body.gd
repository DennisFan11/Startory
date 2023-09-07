extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$body.position = Global.player_position
	$body.linear_damp = Global.damp

func _physics_process(delta):
	var max
	if Global.running == true:
		max = Global.max_run_speed
	else:
		max = Global.max_speed
	var vec = Global.move_vector * (Global.speed + Global.damp)
	
	if ($body.linear_velocity + vec).length() <= max:
		$body.apply_central_impulse(vec)
		
	Global.player_position=$body.position
