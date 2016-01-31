
extends Node2D

var global

var number_spawners = 0
var number_buttons = 0

func _ready():
	# Initialization here
	global = get_node("/root/global")
	
	set_fixed_process(true)
	
	# Spawner timers connect
	var spawners = get_tree().get_nodes_in_group("spawners")
	for sp in spawners:
		sp.connect("spawn_timer",self, "spawn_enemy")
		sp.connect("spawn_dead", self, "less_spawners")
	number_spawners = spawners.size()
	# Buttons
	var buttons = get_tree().get_nodes_in_group("buttons")
	for b in buttons:
		b.connect("player_pressed", self, "can_open_door")
	# Turrets
	var turrets = get_tree().get_nodes_in_group("turrets")
	for t in turrets:
		t.connect("turret_timer", self, "turret_bullet")
	pass

func _fixed_process(delta):
	get_tree().call_group(0,"enemies","set_target",get_node("Players/Player").get_pos())

func turret_bullet(global_pos, bullet_direction):
	var newBullet = global.Actors["Bullet"].instance()
	newBullet.set_global_pos(global_pos)
	newBullet.set_direction(bullet_direction)
	add_child(newBullet)

func less_spawners():
	number_spawners -= 1
	can_open_door()

func can_open_door():
	var buttons = get_tree().get_nodes_in_group("buttons")
	var button_able = true
	for b in buttons:
		if b.is_pressed == false:
			button_able = false
	
	if(number_spawners == 0 and button_able == true):
		get_tree().call_group(0,"doors", "queue_free")

func spawn_enemy(pos):
	var newEnemy = global.Actors["Enemy1"].instance()
	newEnemy.set_pos(pos)
	add_child(newEnemy)

