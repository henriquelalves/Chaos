
extends KinematicBody2D

var global

# Movement Variables
var key_movements = {}
var speed = 2.0
var direction = "down"
var is_moving = false
# Knockback
var is_knockback = false
var knockback_direction = Vector2()
# Falling
var is_falling = false
var target_fall = 0
var checkpoint = Vector2()

# Public functions
func knockback(var from_pos, var strength):
	knockback_direction = (Vector2(get_global_pos() - from_pos).normalized())*strength
	is_knockback = true

# ~private~ functions
func _ready():
	global = get_node("/root/global")
	add_to_group("players")
	# Normal initialization
	key_movements["up"] = OS.find_scancode_from_string("w") # Returns integer
	key_movements["down"] = OS.find_scancode_from_string("s")
	key_movements["right"] = OS.find_scancode_from_string("d")
	key_movements["left"] = OS.find_scancode_from_string("a")
	
	# Set processes
	set_process_input(true)
	set_fixed_process(true)
	
	# Set checkpoint
	checkpoint = get_global_pos()
	
	# Signal
	get_node("PlayerEnemyCollision").connect("body_enter", self, "on_body_enter") 
	get_node("Sword").connect("body_enter", self, "on_body_enter_sword")
	get_node("PlayerEnemyCollision").connect("area_enter", self, "on_body_enter")
	get_node("Sword").connect("area_enter", self, "on_body_enter_sword")
	get_node("PlayerEnemyCollision").connect("area_exit", self, "on_body_exit")
	pass

func on_body_enter(body):
	print(body.get_owner())
	if(body.is_in_group("enemies")):
		knockback(body.get_global_pos(), 30)
		global.players_life -= 1
	elif(body.is_in_group("spawners")):
		knockback(body.get_global_pos(), 20)
	elif(body.is_in_group("holes")):
		if(is_falling == false):
			target_fall = body.get_global_pos()
		else:
			if(get_global_pos().distance_to(target_fall) > get_global_pos().distance_to(body.get_global_pos())):
				target_fall = body.get_global_pos()
		is_falling = true

func on_body_exit(body):
	if(body.is_in_group("holes")):
		if(body.get_global_pos() == target_fall):
			is_falling = false

func on_body_enter_sword(body):
	if(body.get_name() == "EnemyArea"):
		knockback(body.get_global_pos(), 10)
	elif(body.get_name() == "Spawner"):
		knockback(body.get_global_pos(), 20)

func _fixed_process(delta):
	
	if(is_knockback == false):
		if(is_moving):
			if(direction == "up"):
				move(Vector2(0,-speed))
			elif(direction == "down"):
				move(Vector2(0,speed))
			elif(direction == "right"):
				move(Vector2(speed,0))
			elif(direction == "left"):
				move(Vector2(-speed,0))
	else:
		move(knockback_direction)
		is_knockback = false
	if(is_falling):
		print(target_fall)
		var delta = Vector2(target_fall - get_global_pos())
		var fall_vel = 0.2
		if(delta.length() < 32.0):
			fall_vel = 0.5
		if(delta.length() < 16.0):
			fall_vel = 1.0
		move(Vector2(target_fall - get_global_pos()).normalized()*fall_vel)
		if(Vector2(target_fall - get_global_pos()).length() < 6.0):
			move_to(checkpoint)

func _input(event):
	if(event.type == InputEvent.KEY and event.is_pressed() == true ):
		if(event.scancode == key_movements["up"]):
			direction = "up"
			is_moving = true
			get_node("AnimationPlayer").play("default")
			get_node("AnimationSword").play("sword_up")
		elif(event.scancode == key_movements["down"]):
			direction = "down"
			is_moving = true
			get_node("AnimationSword").play("sword_down")
		elif(event.scancode == key_movements["left"]):
			direction = "left"
			is_moving = true
			get_node("AnimationPlayer").play("movement_left")
			get_node("AnimationSword").play("sword_left")
		elif(event.scancode == key_movements["right"]):
			direction = "right"
			is_moving = true
			get_node("AnimationSword").play("sword_right")
	elif(event.type == InputEvent.KEY and event.is_pressed() == false):
		is_moving = false
		get_node("AnimationPlayer").stop(false)