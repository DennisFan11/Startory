@tool
extends Path2D
func _ready():
	$blood_meat.position=Vector2(0,0)
var time=0
@export var anime = false
@export var 擺幅:float = 1
@export var 波長 = 2
@export var 波速 = 1

@export var 擺幅2:float = 1
@export var 波長2 = 2
@export var 波速2 = 1

func _process(delta):
	time= time+delta
	var points = curve.get_baked_points()
	var save = curve.get_baked_points()
	var dist = 0
	for i in range(points.size()):
		dist+=(points[i]-points[i-1]).length()
		var angle
		if i != points.size()-1:
			angle=(points[i+1] - points[i]).normalized().rotated(PI/2)
		else:
			angle=(points[i] - points[i-1]).normalized().rotated(PI/2)
		var wave1 = (sin((time*波速+dist)/波長)*擺幅) * angle
		var wave2 = (sin((time*波速2+dist)/波長2)*擺幅2) * angle
		save[i]+=wave1
		save[i]+=wave2
	$blood_meat.points = save
		
