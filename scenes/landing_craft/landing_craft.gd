extends Node2D

var door = true
var doorMove = 20
var doorSpeed= 0.5
var doorProcess:float = 0

var fireArry = []
var fires:PackedVector2Array = []


func _ready():
	$body.position = Global.player_position
	$body.linear_damp = Global.damp
	_火焰預處理()


func _process(delta):
	_火焰幀處理()
	_門幀處理(delta)
	
func _門幀處理(delta):
	var L = $body/landing_craft/door
	var R = $body/landing_craft/door2
	if (door == true):
		if (doorProcess >= 1):
			doorProcess = 1
		else:
			doorProcess += doorSpeed*delta
	else:
		if (doorProcess <= 0):
			doorProcess = 0
		else:
			doorProcess -= doorSpeed*delta
	L.position = Vector2(-1,0)*doorProcess*doorMove
	R.position = Vector2(1,0)*doorProcess*doorMove
			
		
		


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
	if ($body.linear_velocity + vec).length() <= max:
		$body.apply_central_impulse(vec)
	Global.player_position=$body.position
	

func _火焰預處理():
	fireArry.append($body/fire)
	fireArry.append($body/fire2)
	fireArry.append($body/fire3)
	fireArry.append($body/fire4)
	fireArry.append($body/fire5)
	fireArry.append($body/fire6)
	fireArry.append($body/fire7)
	fireArry.append($body/fire8)
	for i in fireArry:
		fires.append(i.points[1])
func _火焰幀處理():
	var fire_move = $"body".linear_velocity/20
	var rand = float(randi_range(0,50))/100
	for i in range(fireArry.size()):
		fireArry[i].points[1] = fires[i] + (fires[i]*rand) + fire_move.rotated(PI)*1
