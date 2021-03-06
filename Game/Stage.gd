
extends Node2D

var global

export(String) var next_stage = ""

var number_spawners = 0
var number_buttons = 0

var run_timer = true
var stage_timer = 0.0

func _ready():
	# Initialization here
	global = get_node("/root/global")
	
	set_fixed_process(true)
	
	for i in range(0,25):
		for j in range(0,19):
			var set_floor = global.Actors["Floor"].instance()
			set_floor.set_global_pos(Vector2(i*32 + 16,j*32 + 16))
			add_child(set_floor)
	
	# Tilemap set
	var tileset = get_node("Tilemap").get_tileset()
	for i in get_node("Tilemap").get_used_cells():
		var tile_name = tileset.tile_get_name(get_node("Tilemap").get_cell(i.x,i.y))
		var new_child = global.Actors[tile_name].instance()
		new_child.set_global_pos(Vector2(i.x*32 + 16,i.y*32 + 16))
		add_child(new_child)
		# Check on dictionary
		if(global.stages[get_name()].has(new_child.get_global_pos())):
			new_child.player_name = global.stages[get_name()][new_child.get_global_pos()]
	
	get_node("Tilemap").queue_free()
	
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
	
	# Timer!
	stage_timer = global.global_timer
	
	if(get_name() != "Stage 7"):
		get_node("MusicPlayer").play("Chaos Stage")
	else:
		get_node("MusicPlayer").play("Chaos Boss")
	
	pass

func _fixed_process(delta):
	# stage timer
	if(run_timer):
		stage_timer -= delta
	var total_seconds = ceil(stage_timer)
	var seconds = int(total_seconds)%60
	var str_seconds = str(seconds)
	if (str_seconds.length() == 1):
		if str_seconds == "0":
			str_seconds += "0"
		else:
			str_seconds = "0" + str_seconds
	var minutes = floor(total_seconds/60)
	var str_minutes = str(minutes)
	var timer_string = str_minutes + ":" + str_seconds
	get_node("Timer_anchor/Timer").set_text(timer_string)
	if(stage_timer <= 0):
		global.goto_scene("res://Game/Game_over.scn")
	
	var players = get_tree().get_nodes_in_group("players")
	var players_pos = []
	for p in players:
		players_pos.push_back(p.get_global_pos())
	get_tree().call_group(0,"enemies","set_target",players_pos)
	
	# Check if this stage is finished
	for p in players:
		if p.get_global_pos().y < 16:
			if(next_stage != ""):
				# Save state of this stage and go to next one
				var spawners = get_tree().get_nodes_in_group("spawners")
				var buttons = get_tree().get_nodes_in_group("buttons")
				global.global_timer = stage_timer
				var comp_string = "res://Game/" + next_stage + ".scn"
				global.goto_scene(comp_string)

func turret_bullet(global_pos, bullet_direction):
	var newBullet = global.Actors["Bullet"].instance()
	newBullet.set_global_pos(global_pos)
	newBullet.set_direction(bullet_direction)
	add_child(newBullet)

func less_spawners(spawner):
	number_spawners -= 1
	# Set player name on global
	global.stages[get_name()][spawner.get_global_pos()] = spawner.player_name
	can_open_door()

func can_open_door():
	var buttons = get_tree().get_nodes_in_group("buttons")
	var button_able = true
	for b in buttons:
		if b.is_pressed == false:
			button_able = false
	
	if(button_able == false):
		for b in buttons:
			b.player_name = null
	
	if(number_spawners == 0 and button_able == true):
		var doors = get_tree().get_nodes_in_group("doors")
		if(doors.empty() == false):
			for b in buttons:
				
				global.stages[get_name()][b.get_global_pos()] = b.player_name
			get_tree().call_group(0,"doors", "queue_free")

func force_open():
	get_tree().call_group(0,"doors", "queue_free")

func spawn_enemy(pos):
	var newEnemy = global.Actors["Enemy1"].instance()
	newEnemy.set_pos(pos)
	add_child(newEnemy)

