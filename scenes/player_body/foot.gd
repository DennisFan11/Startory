@tool
extends Path2D
func _ready():
	$blood_meat.position=Vector2(0,0)

func _process(delta):
	var points = curve.get_baked_points()
	$blood_meat.points=points
