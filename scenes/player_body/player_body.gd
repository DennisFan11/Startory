extends Node2D

var lfire:Vector2
var Rfire:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	$body.position = Global.player_position
	$body.linear_damp = Global.damp
	lfire=$body/fire.points[1]
	Rfire=$body/fire2.points[1]


func _process(delta):
	var fire_move = $"body".linear_velocity/20
	var rand = float(randi_range(0,50))/100
	$body/fire.points[1]=lfire + lfire*rand + fire_move.rotated(PI)*1
	$body/fire2.points[1]=Rfire + Rfire*rand + fire_move.rotated(PI)*1


func _physics_process(delta):
	var max
	var speed
	if Global.running == true:
		max = Global.max_run_speed
		speed = Global.run_speed
	else:
		max = Global.max_speed
		speed = Global.speed
		
		
	var vec = Global.move_vector * (speed + Global.damp)
	print($body.linear_velocity)
	if ($body.linear_velocity + vec).length() <= max:
		$body.apply_central_impulse(vec)
		
	Global.player_position=$body.position
