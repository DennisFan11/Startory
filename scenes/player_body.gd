@tool
extends Node2D
@export var step:float = 10
var this_in = []
var this_out = []
var leg_in = []
var leg_out = []

var index = [0,3,1,2]
var id = 0

func _ready():
	$body.linear_damp = Global.damp
	_leg_add()
	for i in range(4):
		leg_in[i].position = this_in[i].global_position
	for i in range(4):
		leg_out[i].position = this_out[i].global_position
	
	
	
	
func _leg_move(delta,target):
	for i in range(4):
		leg_in[i].position = this_in[i].global_position
	if id == 4:
		id = 0
	var i = index[id]
	var target_len = (leg_out[i].position - this_out[i].global_position).length()
	var target_move_len = (leg_out[i].position - this_out[i].global_position-target/3).length()
	
	if leg_out[i].get_node("..").moving == false:
		if target_len >= 30:
			leg_out[i].get_node("..").moving = true
			
	elif target_move_len >= 10:
		leg_out[i].position = leg_out[i].position.lerp(this_out[i].global_position+target/3,delta*20)
	else:
		leg_out[i].get_node("..").moving = false
		id += 1
			
			
	
	
	

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
		Global.player_position = $body.position
		$speed.points[0] = $body.position
		$speed.points[1] = $body.linear_velocity + $body.position
		_leg_move(delta,$body.linear_velocity)
	
func _leg_add():
	this_in.append($body/in1)
	this_in.append($body/in2)
	this_in.append($body/in3)
	this_in.append($body/in4)
	this_out.append($body/out1)
	this_out.append($body/out2)
	this_out.append($body/out3)
	this_out.append($body/out4)
	leg_in.append($leg/in)
	leg_in.append($leg2/in)
	leg_in.append($leg3/in)
	leg_in.append($leg4/in)
	leg_out.append($leg/out)
	leg_out.append($leg2/out)
	leg_out.append($leg3/out)
	leg_out.append($leg4/out)
	for i in range(4):
		leg_in[i].get_node("..").angle = i
