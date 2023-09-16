extends Node2D
@export var c = Curve.new()
var enable:bool = true
func _process(delta):
	if enable == true:
		var pos = $Marker2D.global_position
		var range = 800
		var normal = 50
		if not Engine.is_editor_hint():
			pos = Global.player_position
			range = Global.player_view_range
		var dist = Vector2(pos - global_position).length()
		var angle = Vector2(pos - global_position).angle()-global_rotation
		dist /= range
		dist = c.sample(dist/3)*3
		if dist > 3:
			dist = 3
		material.set_shader_parameter("dist",float(dist))
		material.set_shader_parameter("angle",float(angle))
