extends Node

var players_life = 20
var Actors = {}

var current_scene = null

var number_boss_defeated = 0
var global_timer = 1000.0

var stages = {}
var boss_final_hit

var players_keys = {}

func _ready():
	#Initalizer
	Actors["Enemy1"] = load("res://Game/Enemy1.scn")
	Actors["Bullet"] = load("res://Game/Bullet.scn")
	Actors["Wall"] = load("res://Game/Wall.scn")
	Actors["Player"] = load("res://Game/Player.scn")
	Actors["Player1"] = load("res://Game/Player1.scn")
	Actors["Player2"] = load("res://Game/Player2.scn")
	Actors["Player3"] = load("res://Game/Player3.scn")
	Actors["Turret"] = load("res://Game/Turret.scn")
	Actors["Spawner"] = load("res://Game/Spawner.scn")
	Actors["Hole"] = load("res://Game/Hole.scn")
	Actors["Door"] = load("res://Game/Door.scn")
	Actors["Button"] = load("res://Game/Button.scn")
	Actors["Floor"] = load("res://Game/Floor.scn")
	Actors["FloatingWarning"] = load("res://Game/FloatingWarning.scn")
	Actors["ParticleHit"] = load("res://Game/ParticleHit.scn")
	
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
	# stages initialization
	stages["Stage"] = {}
	stages["Stage 1"] = {}
	stages["Stage 2"] = {}
	stages["Stage 3"] = {}
	stages["Stage 4"] = {}
	stages["Stage 5"] = {}
	stages["Stage 6"] = {}
	stages["Stage 7"] = {}
	pass

func initalize_stage():
	players_life = 20
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene",path)
	
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)