extends Sprite2D
@export var id=1
func _ready():
	texture=Global.dirt
	set_region_rect(Rect2(randi_range(0, 128),randi_range(0, 128),16,16))
	rotation=PI/2*randi_range(0, 3)
	
