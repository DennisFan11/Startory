@tool
extends Node2D
var enable:bool = true
var normal:float = 0.2
var A1
var A2
var B1
var B2
func _process(delta):
	if enable == true:
		var pos = $Marker2D.global_position
		var range = 150
		if not Engine.is_editor_hint():
			pos = Global.player_position
			range = Global.player_view_range
		var dist = Vector2(pos - global_position)
		var angle = Vector2(pos - global_position).angle()
		dist /= range
		if dist.x > 1:
			dist.x=1
		if dist.y > 1:
			dist.y=1
		
		B1 = normal + sin(angle)*dist.length()*normal
		B2 = normal - sin(angle)*dist.length()*normal
		A1 = normal + cos(angle)*dist.length()*normal
		A2 = normal - cos(angle)*dist.length()*normal
		material.set_shader_parameter("A1",float(A1))
		material.set_shader_parameter("A2",float(A2))
		material.set_shader_parameter("B1",float(B1))
		material.set_shader_parameter("B2",float(B2))
