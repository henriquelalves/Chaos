
extends Area2D

var velocity = Vector2(2,1)

var life = 10

var player_name
var target_pos
var global

func _ready():
	global = get_node("/root/global")
	set_fixed_process(true)
	get_node("EnemyArea").connect("area_enter", self, "on_area_enter")
	add_to_group("enemies")
	
	if(global.boss_final_hit != null):
		player_name = global.boss_final_hit
	
	pass

func on_area_enter(area):
	if(area.get_name() == "Sword"):
		life -= 1
		if(life <= 0):
			if(player_name == null or area.get_parent().get_name() == player_name):
				global.boss_final_hit = area.get_parent().get_name()
				queue_free()

func set_target(players_pos):
	target_pos = Vector2(0,0)
	for p in players_pos:
		if target_pos == Vector2(0,0):
			target_pos = p
		else:
			if ((get_global_pos() - target_pos).length() > (get_global_pos() - p).length()):
				target_pos = p

func _fixed_process(delta):
	# Invert velocity
	if(get_global_pos().x <= 64 or get_global_pos().x >= 736):
		velocity.x = -velocity.x
	if(get_global_pos().y <= 64 or get_global_pos().y >= 544):
		velocity.y = -velocity.y

