@tool
extends Node2D
@export var 步長 = 10
var markers = []
var body_markers = []
var body_target_markers = []

func _ready():
	markers.append($leg/Marker2D)
	markers.append($leg2/Marker2D)
	markers.append($leg3/Marker2D)
	markers.append($leg4/Marker2D)
	body_markers.append($leg/Marker1)
	body_markers.append($leg2/Marker1)
	body_markers.append($leg3/Marker1)
	body_markers.append($leg4/Marker1)
	body_target_markers.append($body/Marker1)
	body_target_markers.append($body/Marker2)
	body_target_markers.append($body/Marker3)
	body_target_markers.append($body/Marker4)
	
func _leg_move():
	var pos = Global.player_position
	

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
	

