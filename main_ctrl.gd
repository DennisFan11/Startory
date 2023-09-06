extends Node

var scen_ui = preload("res://scenes/title_ui/title_ui.tscn")
var ui
var scen_game = preload("res://scenes/game_ctrl/game_ctrl.tscn")
var game

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ctrl = $"."
	_UiAdd()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
	
func _GameStart():
	_GameLoad(Global._GenMap())
	
	
func _GameLoad(map_data):
	_UiRemove()
	_GameAdd()
	Global.Gctrl=game
	game.map._load(map_data)







func _GameAdd():
	game = scen_game.instantiate()
	add_child(game)
	
func _GameRemove():
	game.queue_free()
	
func _UiAdd():
	ui = scen_ui.instantiate()
	add_child(ui)
	
func _UiRemove():
	ui.queue_free()
