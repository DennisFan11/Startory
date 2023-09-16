extends Node
var ctrl
var Gctrl
var map = {}
var choice = 0

var player_view_range = 400 #pix
var damp:float = 10 #每幀pix
var speed:float = 12 #每幀pix 12
var run_speed:float = 16
var max_speed:float = 100 
var max_run_speed:float = 200 #150

var dirt = preload("res://asset_lib/sprites/dirt.png")



var player_position:Vector2 = Vector2.ZERO
var move_vector:Vector2 = Vector2.ZERO
var running:bool = false
var shooting:bool = false
var aim:bool = false

var hp:int = 10


var block_size = 16
var chunk_size = 9
var chunk_array_load = empty_chunk_array(9) #9*9
var chunk_array_loaded = []






func _GenMap():
	var mapdata = {
		"floor":empty_map_array(2000, 2000, 1),
		"wall":empty_map_array(2000, 2000, 0),
		"unit":[],
		"builind":[]
	}
	
	return(mapdata)
	
func empty_chunk_array(size:int): #arry = Vector2([0,0], [0,1])
	var output = []
	if (size % 2 == 0):
		size += 1
	for x in range(size):
		for y in range(size):
			output.append( Vector2(x-(size-1)/2, y-(size-1)/2) )
	return (output)
			
	
	
func empty_map_array(x:int, y:int, input:int): #arry=[[0,0], [0,0]]
	var output = []
	for i in range(x):
		output.append([])
		for l in range(y):
			output[i].append(input)
	return (output)

