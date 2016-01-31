
extends Control

# member variables here, example:
var used_keys = []
var size = 26

var global

func _ready():
	set_process_input(true)
	global = get_node("/root/global")
	
	var i = 65
	while i <= 90:
		used_keys.append(i)
		i += 1
	set_keys("Player1")
	set_keys("Player2")
	set_keys("Player3")
	set_labels_inputs()

func _input(event):
	if(event.type == InputEvent.KEY and event.is_pressed() == true ):
		if event.scancode == OS.find_scancode_from_string("q"):
			global.goto_scene("res://Game/Stage.scn")

func set_keys(name):
	get_node(name).key_movements["up"] = remove_used_key()
	print(get_node(name).key_movements["up"])
	get_node(name).key_movements["down"] = remove_used_key()
	get_node(name).key_movements["left"] = remove_used_key()
	get_node(name).key_movements["right"] = remove_used_key()
	
func remove_used_key():
	randomize();
	var ind = randi() % size
	size -= 1
	var value = used_keys[ind]
	used_keys[ind] = used_keys[size]
	return value

func set_labels_inputs():
	get_node("Left1").set_text(OS.get_scancode_string(get_node("Player1").key_movements["left"]))
	get_node("Right1").set_text(OS.get_scancode_string(get_node("Player1").key_movements["right"]))
	get_node("Left2").set_text(OS.get_scancode_string(get_node("Player2").key_movements["left"]))
	get_node("Right2").set_text(OS.get_scancode_string(get_node("Player2").key_movements["right"]))
	get_node("Left3").set_text(OS.get_scancode_string(get_node("Player3").key_movements["left"]))
	get_node("Right3").set_text(OS.get_scancode_string(get_node("Player3").key_movements["right"]))
	get_node("Up1").set_text(OS.get_scancode_string(get_node("Player1").key_movements["up"]))
	get_node("Down1").set_text(OS.get_scancode_string(get_node("Player1").key_movements["down"]))
	get_node("Up2").set_text(OS.get_scancode_string(get_node("Player2").key_movements["up"]))
	get_node("Down2").set_text(OS.get_scancode_string(get_node("Player2").key_movements["down"]))	
	get_node("Up3").set_text(OS.get_scancode_string(get_node("Player3").key_movements["up"]))
	get_node("Down3").set_text(OS.get_scancode_string(get_node("Player3").key_movements["down"]))