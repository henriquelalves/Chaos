
extends Area2D

var velocity = Vector2(3,2)

var life = 10

var timer_limit = 2.0
var timer = 0.0

var player_name
var target_pos
var global

func _ready():
	global = get_node("/root/global")
	set_fixed_process(true)
	connect("area_enter", self, "on_area_enter")
	add_to_group("enemies")
	
	if(global.boss_final_hit != null):
		player_name = global.boss_final_hit
	
	pass

func on_area_enter(area):
	if(area.get_name() == "Sword"):
		print("oi")
		life -= 1
		if(life <= 0):
			if(player_name == null or area.get_parent().get_name() == player_name):
				global.boss_final_hit = area.get_parent().get_name()
				get_parent().force_open()
				queue_free()
			else:
				var label = global.Actors["FloatingWarning"].instance()
				add_child(label)

func set_target(players_pos):
	target_pos = Vector2(0,0)
	for p in players_pos:
		if target_pos == Vector2(0,0):
			target_pos = p
		else:
			if ((get_global_pos() - target_pos).length() > (get_global_pos() - p).length()):
				target_pos = p

func _fixed_process(delta):
	# Movement
	set_global_pos(get_global_pos() + velocity)
	# Bullet spawn
	timer += delta
	if timer > timer_limit:
		timer -= timer_limit
		var new_bullet = global.Actors["Bullet"].instance()
		new_bullet.direction = (target_pos - get_global_pos()).normalized()*4
		get_parent().add_child(new_bullet)
		new_bullet.set_global_pos(get_global_pos())
	# Invert velocity
	if(get_global_pos().x <= 64 or get_global_pos().x >= 704):
		velocity.x = -velocity.x
	if(get_global_pos().y <= 64 or get_global_pos().y >= 512):
		velocity.y = -velocity.y

