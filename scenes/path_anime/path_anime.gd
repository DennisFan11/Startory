@tool
extends PathFollow2D
@export var start = false
@export var tot = 3
var pos = Vector2.ZERO

func _ready():
	pass # Replace with function body.
func _play():
	start =true
func _stop():
	start =false
	time = 0
	progress_ratio=0
	
var time = 0

func _process(delta):
	if start == true:
		time+=delta
		progress_ratio=time/tot
		if time/tot >= 1:
			time = 0
		pos = position
