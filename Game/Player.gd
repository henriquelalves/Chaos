
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
var checkpoint = Vector2()

# Public functions
func knockback(var from_pos, var strength):
	knockback_direction = (Vector2(get_global_pos() - from_pos).normalized())*strength
	is_knockback = true

# ~private~ functions
func _ready():
	global = get_node("/root/global")
	add_to_group("players")
	
	get_node("AnimationPlayer").play("default")
	get_node("AnimationSword").play("default")
	
	# Normal initialization
	key_movements["up"] = OS.find_scancode_from_string("w") # Returns integer
	key_movements["down"] = OS.find_scancode_from_string("s")
	key_movements["right"] = OS.find_scancode_from_string("d")
	key_movements["left"] = OS.find_scancode_from_string("a")
	# Override
	if(global.players_keys.has(get_name())):
		key_movements = global.players_keys[get_name()]
	
	
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
	
	if(body.is_in_group("enemies")):
		knockback(body.get_global_pos(), 30)
		get_parent().stage_timer -= 1
	elif(body.is_in_group("spawners")):
		knockback(body.get_global_pos(), 20)
	elif(body.is_in_group("holes")):
		is_falling = true

func on_body_exit(body):
	if(body.is_in_group("holes")):
		var bodies = get_node("PlayerEnemyCollision").get_overlapping_bodies()
		for b in bodies:
			if b.is_in_group("holes"):
				return
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
		# Neat particle effect for playerfeedback
		var particleEffect = global.Actors["ParticleHit"].instance()
		get_parent().add_child(particleEffect)
		particleEffect.set_color(Color(255,0,0))
		particleEffect.set_global_pos(get_global_pos())
		print(particleEffect.is_emitting())
		# Knockback Movement
		move(knockback_direction)
		is_knockback = false
	if(is_falling):
		var bodies = get_node("PlayerEnemyCollision").get_overlapping_areas()
		var nearest_distance = Vector2(0,0)
		for b in bodies:
			if b.is_in_group("holes"):
				if(nearest_distance == Vector2(0,0) or (get_global_pos() - b.get_global_pos()).length() < (get_global_pos() - nearest_distance).length()):
					nearest_distance = b.get_global_pos()
		
		var delta = Vector2(nearest_distance - get_global_pos())
		var fall_vel = 0.0
		if(delta.length() < 23.0):
			fall_vel = 0.5
		if(delta.length() < 16.0):
			fall_vel = 3.0
		move(Vector2(nearest_distance - get_global_pos()).normalized()*fall_vel)
		if(Vector2(nearest_distance - get_global_pos()).length() < 4.0):
			move_to(checkpoint)
			get_parent().stage_timer -= 2

func _input(event):
	if(event.type == InputEvent.KEY and event.is_pressed() == true ):
		if(event.scancode == key_movements["up"]):
			direction = "up"
			is_moving = true
			get_node("AnimationPlayer").play("move_up")
			get_node("AnimationSword").play("sword_up")
		elif(event.scancode == key_movements["down"]):
			direction = "down"
			is_moving = true
			get_node("AnimationPlayer").play("move_down")
			get_node("AnimationSword").play("sword_down")
		elif(event.scancode == key_movements["left"]):
			direction = "left"
			is_moving = true
			get_node("AnimationPlayer").play("move_left")
			get_node("AnimationSword").play("sword_left")
		elif(event.scancode == key_movements["right"]):
			direction = "right"
			is_moving = true
			get_node("AnimationPlayer").play("move_right")
			get_node("AnimationSword").play("sword_right")
	elif(event.type == InputEvent.KEY and event.is_pressed() == false):
		for k in key_movements:
			if event.scancode == key_movements[k]:
				is_moving = false
				get_node("AnimationPlayer").stop(false)