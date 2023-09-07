extends Node2D


func _process(delta):
	_camera()
	
func _physics_process(delta):
	_player_action()
	
func _player_action():
	var i = Vector2.ZERO
	var run = false
	var shot = false
	var aim = false
	if Input.is_action_pressed("up"):
		i.y-=1
	if Input.is_action_pressed("down"):
		i.y+=1
	if Input.is_action_pressed("left"):
		i.x-=1
	if Input.is_action_pressed("right"):
		i.x+=1
	if Input.is_action_pressed("shift"):
		run=true
	if Input.is_action_pressed("shot"):
		shot=true
	if Input.is_action_pressed("aim"):
		aim=true
	Global.move_vector = i.normalized()
	Global.running = run
	Global.shooting = shot
	Global.aim = aim
	
	
	
	
func _camera():
	if Input.is_action_just_pressed("zoom_in"):
		$Camera.zoom *=1.1
	if Input.is_action_just_pressed("zoom_out"):
		$Camera.zoom *=0.9
	var pos = Global.player_position
	$Camera.position = pos
	
	

