extends Sprite2D
@export var id=1
func _ready():
	set_region_rect(Rect2(randi_range(0, 128),randi_range(0, 128),64,64))
	
