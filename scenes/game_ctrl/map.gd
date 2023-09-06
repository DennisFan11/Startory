extends Node2D

var floor = [
	"air",
	preload("res://scenes/floors/01.tscn")
]
var mapdata = Global.map
var block_size = Global.block_size
var chunk_size = Global.chunk_size
var chunk_array_load = Global.chunk_array_load
var chunk_array_loaded = Global.chunk_array_loaded
var pos = Global.player_position

func _datasync():
	mapdata = Global.map
	block_size = Global.block_size
	chunk_size = Global.chunk_size
	chunk_array_load = Global.chunk_array_load
	chunk_array_loaded = Global.chunk_array_loaded
	pos = Global.player_position

func _process(delta):
	var block_pos = Vector2(int(pos.x), int(pos.y))
	block_pos /= block_size
	var chunk_pos = block_pos/chunk_size
	_floorLoad(chunk_pos)
	
func _floorLoad(chunk_pos : Vector2):
	var save = []
	var need = []
	var dontneed = []
	for i in chunk_array_load:
		need.append(i + chunk_pos)
	
	for i in chunk_array_loaded:
		if i not in need:
			dontneed.append(i)
	for i in need:
		if i not in chunk_array_loaded:
			save.append(i)
	chunk_array_loaded=need
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
	var bpos = cpos*chunk_size
	for x in range(chunk_size):
		for y in range(chunk_size):
			var ix = bpos.x+x
			var iy = bpos.y+y
			var id = mapdata.floor[ix][iy]
			if typeof(id) ==TYPE_INT && id !=0 && ix>=0 &&iy>=0:
				mapdata.floor[ix][iy] = floor[id].instantiate()
				add_child(mapdata.floor[ix][iy])
				mapdata.floor[ix][iy].position=Vector2(ix*block_size+block_size/2,iy*block_size+block_size/2)
			
		
func _remove(cpos:Vector2):
	var bpos = cpos*chunk_size
	for x in range(chunk_size):
		for y in range(chunk_size):
			var ix = bpos.x+x
			var iy = bpos.y+y
			var id = mapdata.floor[ix][iy].id
			if typeof(id) ==TYPE_CALLABLE:
				mapdata.floor[ix][iy].queue_free()
				mapdata.floor[ix][iy] = id
		
	
	
