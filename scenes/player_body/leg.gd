extends Node2D
var angle = 0
var rot = false
var Out = 5
var In = 20
var curve1
var moving:bool = false
var using:bool = false
var choice:bool = false
var dmage = false
var charged = 0
var mouse = Vector2.ZERO
var move_speed = 20

func _ready():
	var shaderI = $leg_path/blood_meat.material.duplicate()
	$leg_path/blood_meat.set_material(shaderI)
	
	curve1 = $leg_path.curve
	$leg_path/blood_meat.position = Vector2(0,0)
	$leg_path/blood_meat.points = curve1.get_baked_points()
	curve1.set_point_out(0,($out.position-$in.position).normalized()*Out)
	
func _physics_process(delta):
	var target_vec = ($out.position-$CharacterBody2D.position)
	$CharacterBody2D.velocity = target_vec*move_speed
	$CharacterBody2D.move_and_slide()
	if angle == Global.choice:
		if Global.shooting == true:
			using = true
			dmage = false
			charged = 1
			mouse = get_global_mouse_position()
			curve1.set_point_in(2,Vector2.ZERO)
			$leg_path/blood_meat.material.set_shader_parameter("choice",true)
		elif charged != 0:
			$leg_path/blood_meat.material.set_shader_parameter("choice",false)
			using = true
			if charged == 1:
				dmage = true
			charged-=delta*5
			if charged<=0:
				$"..".leg_out[Global.choice].global_position = $"..".this_out[Global.choice].global_position
				charged = 0
	else:
		$leg_path/blood_meat.material.set_shader_parameter("choice",false)
		if charged != 0:
			$"..".leg_out[Global.choice].global_position = $"..".this_out[Global.choice].global_position
			charged = 0
		using = false
		dmage = false
		
		
	if dmage == true: #出拳檢測
		for coll in $CharacterBody2D.get_slide_collision_count():
			if dmage == false:
				break
			var cEvent = $CharacterBody2D.get_slide_collision(coll)
			if cEvent :
				var collision = cEvent.get_collider()
				if collision.is_in_group("can_hit"):
					print(collision)
					var pos = collision.to_local(cEvent.get_position())
					
					var angle = (collision.global_position - $CharacterBody2D.global_position).normalized()
					var F = (angle*punch_force)
					collision.apply_impulse(F,pos)
					dmage = false
					
					charged = 0
					$"..".leg_out[Global.choice].global_position = $"..".this_out[Global.choice].global_position
				
					
var punch_force = 500
var 尾端偏移量 = 20
	
func _process(delta):
	if angle == Global.choice == true and Global.shooting == true:
		尾端偏移量 = 0
	else:尾端偏移量 = 20
	curve1 = $leg_path.curve
	$leg_path/Label.position = $out.position
	curve1.set_point_position(0,$in.position)
	curve1.set_point_position(1,$CharacterBody2D.position)
	var point
	curve1.set_point_position(2,Vector2($CharacterBody2D.position.x,$CharacterBody2D.position.y+尾端偏移量))
	if(angle == 3)or(angle == 1):
		if rot == false:
			point = Vector2(-20,-15)
			
		else:
			point = Vector2(20,-15)
	else:
		if rot == false:
			point = Vector2(20,-15)
		else:
			point = Vector2(-20,-15)
	if angle == Global.choice == false or Global.shooting == false:
		curve1.set_point_in(2,point)
	$leg_path/blood_meat.points = curve1.get_baked_points()
	
