extends Node2D
@export var step:float = 10
var this_in = []
var this_out = []
var leg_in = []
var leg_out = []
var leg_speed = 20
var index = [0,3,1,2]
var id = 0

var speed_velocity = Vector2.ZERO
func _ready():
	var path = load("res://scenes/player_body/leg.tscn")
	for i in range(4):
		var a = path.instantiate()
		add_child(a)
		leg_in.append(a.get_node("in"))
		leg_out.append(a.get_node("out"))
	for i in range(4):
		leg_in[i].get_node("..").angle = i
	this_in.append($body/in1)
	this_in.append($body/in2)
	this_in.append($body/in3)
	this_in.append($body/in4)
	this_out.append($body/out1)
	this_out.append($body/out2)
	this_out.append($body/out3)
	this_out.append($body/out4)
	for i in range(4):
		leg_in[i].position = this_in[i].global_position
	for i in range(4):
		leg_out[i].position = this_out[i].global_position
	_leg_move(0.1,Vector2(0,0))
	for i in leg_out:
		print(i.get_node(".."))
	

	

func _process(delta):
	_speed_line()
	_leg_move(delta,speed_velocity)
	_rotat(delta)
	_choice_leg()
	
func _choice_leg():
	var out
	var min:float = 100000
	var ida = 0
	var outida
	for i in leg_in:
		var dist = (get_global_mouse_position()-i.global_position).length()
		if dist <= min:
			min = dist
			out = i
			outida = ida
		ida+=1
	Global.choice = outida
	

var charge_dist = 30
var charged_length = 200



func _physics_process(delta):
	if not Engine.is_editor_hint():
		var charged = leg_out[Global.choice].get_node("..").charged
		var targetVec = (leg_out[Global.choice].get_node("..").mouse-this_in[Global.choice].global_position).normalized()
		var start_at = this_in[Global.choice].global_position
		var move = leg_out[Global.choice].global_position
		if Global.shooting == true: #沖能
			leg_in[Global.choice].global_position = $body.position+targetVec*10
			leg_out[Global.choice].global_position = start_at+targetVec*charge_dist
		elif charged != 0 : #沖能
			leg_in[Global.choice].global_position = $body.position+targetVec*10
			leg_out[Global.choice].global_position = move.lerp(start_at+targetVec*(charged_length), delta*50) 
			
			
			
		var max
		var speed
		if Global.running == true:
			max = Global.max_run_speed
			speed = Global.run_speed
			leg_speed = 40
		else:
			max = Global.max_speed
			speed = Global.speed
			leg_speed = 20
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

var time =0
var max_time = 0.3
var 容許距離 = 30
var 回歸速度 = 1
var last_pos
func _leg_move(delta,target):
	
	if last_pos != $body.position:
		last_pos = $body.position
		time = 0
	else:
		time += delta
	if time >= max_time: #回歸
		id += 1
		容許距離 = 3
		回歸速度 = 5
	else:
		容許距離 = 30
		回歸速度 = 1
		
	for i in range(4):
		leg_in[i].position = this_in[i].global_position
	if id >= 4:
		id = 0
	#末端設置
	var i = index[id]
	var target_len = (leg_out[i].position - this_out[i].global_position).length()
	var target_move_len = (leg_out[i].position - this_out[i].global_position-target/3).length()
	if leg_out[i].get_node("..").using == false:
		if leg_out[i].get_node("..").moving == false:
			if target_len >= 容許距離:
				#移動開始
				leg_out[i].get_node("..").moving = true
		elif target_move_len >= 10*speed_velocity.length()/100: 
			#移動中
			leg_out[i].position = leg_out[i].position.lerp(this_out[i].global_position+target/3, delta*leg_speed*回歸速度)
		else:
			#移動結束
			leg_out[i].get_node("..").moving = false
			id += 1
	else:
		id += 1
