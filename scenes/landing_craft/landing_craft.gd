extends Node2D
func _ready():
	_火焰預處理()

func _process(delta):
	_火焰幀處理()
	_門幀處理(delta)

func _physics_process(delta):
	pass
	
	
	
var fireArry = []
var fires:PackedVector2Array = []
func _火焰預處理():
	fireArry.append($body/fires/fire)
	fireArry.append($body/fires/fire2)
	fireArry.append($body/fires/fire3)
	fireArry.append($body/fires/fire4)
	fireArry.append($body/fires/fire5)
	fireArry.append($body/fires/fire6)
	fireArry.append($body/fires/fire7)
	fireArry.append($body/fires/fire8)
	for i in fireArry:
		fires.append(i.points[1])
func _火焰幀處理():
	var fire_move = $"body".linear_velocity/20
	var rand = float(randi_range(0,50))/100
	for i in range(fireArry.size()):
		fireArry[i].points[1] = fires[i] + (fires[i]*rand) + fire_move.rotated(PI)*1
var door = true
var doorMove = 20
var doorSpeed= 0.5
var doorProcess:float = 0
func _門幀處理(delta):
	var L = $body/Fake3D/landing_craft/door
	var R = $body/Fake3D/landing_craft/door2
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
