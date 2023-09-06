extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _start():
	Global.ctrl._GameStart()
	
func _load():
	Global.ctrl._GameLoad()
	
func _exit():
	get_tree().quit()

func _on_start_button_down():
	_start()
func _on_load_button_down():
	_load()
func _on_exit_button_down():
	_exit()
