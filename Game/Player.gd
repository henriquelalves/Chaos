
extends KinematicBody2D

# Movement Variables
var key_movements = {}
var speed = 2.0
var direction = "down"
var is_moving = false

# ~private~ functions
func _ready():
	# Normal initialization
	key_movements["up"] = OS.find_scancode_from_string("w") # Returns integer
	key_movements["down"] = OS.find_scancode_from_string("s")
	key_movements["right"] = OS.find_scancode_from_string("d")
	key_movements["left"] = OS.find_scancode_from_string("a")
	
	# Set processes
	set_process_input(true)
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if(is_moving):
		if(direction == "up"):
			move(Vector2(0,-speed))
		elif(direction == "down"):
			move(Vector2(0,speed))
		elif(direction == "right"):
			move(Vector2(speed,0))
		elif(direction == "left"):
			move(Vector2(-speed,0))

func _input(event):
	if(event.type == InputEvent.KEY and event.is_pressed() == true and event.is_echo() == false):
		if(event.scancode == key_movements["up"]):
			direction = "up"
			is_moving = true
			get_node("AnimationPlayer").play("default")
		elif(event.scancode == key_movements["down"]):
			direction = "down"
			is_moving = true
		elif(event.scancode == key_movements["left"]):
			direction = "left"
			is_moving = true
			get_node("AnimationPlayer").play("movement_left")
		elif(event.scancode == key_movements["right"]):
			direction = "right"
			is_moving = true
	elif(event.type == InputEvent.KEY and event.is_pressed() == false):
		is_moving = false
		get_node("AnimationPlayer").stop(false)