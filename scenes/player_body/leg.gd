@tool
extends Path2D
func _ready():
	$blood_meat.position = Vector2(0,0)
	$blood_meat.points = curve.get_baked_points()
func _process(delta):
	$blood_meat.points = curve.get_baked_points()
