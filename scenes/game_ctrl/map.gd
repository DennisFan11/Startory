extends Node2D

var floor = [
	"air",
	preload("res://scenes/floors/01.tscn")
]



func _process(delta):
	
	var block_pos = Vector2(
		int(Global.player_position.x / Global.block_size),
		int(Global.player_position.y / Global.block_size)
		)
	var chunk_pos = Vector2(
		int(block_pos.x / Global.chunk_size),
		int(block_pos.y / Global.chunk_size)
	)
	
	_floorLoad(chunk_pos)
	
func _floorLoad(chunk_pos : Vector2):
	var save = []
	var need = []
	var dontneed = []
	for i in Global.chunk_array_load:
		need.append(i + chunk_pos)
	
	for i in Global.chunk_array_loaded:
		if i not in need:
			dontneed.append(i)
	for i in need:
		if i not in Global.chunk_array_loaded:
			save.append(i)
	Global.chunk_array_loaded=need
	need=save
	if need != []:
		print("load_chunk:",need)
	if dontneed != []:
		print("unload_chunk:",dontneed)
	for i in need:
		_add(i)
	for i in dontneed:
		_remove(i)
		
	
	
func _add(cpos:Vector2):
	var bpos = cpos*Global.chunk_size
	for x in range(Global.chunk_size):
		for y in range(Global.chunk_size):
			var ix = bpos.x+x
			var iy = bpos.y+y
			var id = Global.map.floor[ix][iy]
			if typeof(id) ==TYPE_INT && id !=0 && ix>=0 &&iy>=0:
				Global.map.floor[ix][iy] = floor[id].instantiate()
				add_child(Global.map.floor[ix][iy])
				Global.map.floor[ix][iy].position=Vector2(ix*Global.block_size+Global.block_size/2,iy*Global.block_size+Global.block_size/2)
			
		
func _remove(cpos:Vector2):
	var bpos = cpos*Global.chunk_size
	for x in range(Global.chunk_size):
		for y in range(Global.chunk_size):
			var ix = bpos.x+x
			var iy = bpos.y+y
			if typeof(Global.map.floor[ix][iy]) == TYPE_OBJECT :
				var id = Global.map.floor[ix][iy].id
				Global.map.floor[ix][iy].queue_free()
				Global.map.floor[ix][iy] = id
				
				
			
		
	
	
