
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var global

func _ready():
	global = get_node("/root/global")
	set_process_input(true)
	pass

func _input(event):
	if(event.type == InputEvent.KEY and event.is_pressed() == true ):
		if event.scancode == 32:
			global.number_boss_defeated = 0
			global.players_keys = {}
			global.stages["Stage"] = {}
			global.stages["Stage 1"] = {}
			global.stages["Stage 2"] = {}
			global.stages["Stage 3"] = {}
			global.stages["Stage 4"] = {}
			global.stages["Stage 5"] = {}
			global.stages["Stage 6"] = {}
			global.stages["Stage 7"] = {}
			global.goto_scene("res://Game/Menu.scn")
