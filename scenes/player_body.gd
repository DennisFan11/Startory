
extends Node2D
@export var step:float = 10
var this_in = []
var this_out = []
var leg_in = []
var leg_out = []

var index = [0,3,1,2]
var id = 0

var speed_velocity = Vector2.ZERO
func _ready():
	_leg_add()
	for i in range(4):
		leg_in[i].position = this_in[i].global_position
	for i in range(4):
		leg_out[i].position = this_out[i].global_position
	_leg_move(0.1,Vector2(0,0))
	

	

func _process(delta):
	_speed_line()
	_leg_move(delta,speed_velocity)
	_rotat(delta)
	_choice_leg()
	
func _choice_leg():
	var out
	var min:float = 100000
	for i in range(4):
		var dist = (get_global_mouse_position()-this_out[i].global_position).length()
		if dist < min :
			min = dist
			out = i
	Global.choice = out
	

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
		speed_velocity += Global.move_vector * speed
		if speed_velocity.length()>Global.damp:
			speed_velocity = (speed_velocity.length() - Global.damp) * speed_velocity.normalized()
		else:
			speed_velocity = Vector2.ZERO
		if speed_velocity.length() >= max:
			speed_velocity = max * speed_velocity.normalized()
		$body.move_and_collide(speed_velocity*delta)
		Global.player_position = $body.position
		
		
		
			
func _speed_line():
		$speed.points[0] = $body.position
		$speed.points[1] = speed_velocity + $body.position
		$Label.global_position = ($speed.points[0]+$speed.points[1])/2
		$Label.text = str(int(speed_velocity.length()))+" px/s\n"
		
		
		
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
func _rotat(delta):
	# 平滑地旋轉物體
	if speed_velocity != Vector2.ZERO:
		$body.rotation = lerp_angle($body.rotation, speed_velocity.angle(), delta * 3)
	# 在顛倒時反轉圖片
	var rot
	if abs($body.rotation) > PI/2 and abs($body.rotation) < PI*3/2:
		$body/body.flip_v = true
		rot = true
	else:
		$body/body.flip_v = false
		rot = false
	for i in range(4):
		leg_in[i].get_node("..").rot = rot

func _leg_move(delta,target):
	for i in range(4):
		leg_in[i].position = this_in[i].global_position
	if id == 4:
		id = 0
	var i = index[id]
	var target_len = (leg_out[i].position - this_out[i].global_position).length()
	var target_move_len = (leg_out[i].position - this_out[i].global_position-target/3).length()
	if leg_out[i].get_node("..").using == false:
		if leg_out[i].get_node("..").moving == false:
			if target_len >= 30:
				leg_out[i].get_node("..").moving = true
		elif target_move_len >= 10:
			leg_out[i].position = leg_out[i].position.lerp(this_out[i].global_position+target/3,delta*20)
		else:
			leg_out[i].get_node("..").moving = false
			id += 1
	else:
		id += 1
