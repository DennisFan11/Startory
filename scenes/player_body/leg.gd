@tool
extends Path2D
func _ready():
	$blood_meat.position = Vector2(0,0)
	$blood_meat.points = curve.get_baked_points()
func _process(delta):
	$blood_meat.points = curve.get_baked_points()
	curve.set_point_position(1,$Marker2D.position)
	curve.set_point_position(0,$Marker1.position)
