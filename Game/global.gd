extends Node

var players_life = 20
var Actors = {}

func _ready():
	#Initalizer
	Actors["Enemy1"] = load("res://Game/Enemy1.scn")
	Actors["Bullet"] = load("res://Game/Bullet.scn")
	Actors["Wall"] = load("res://Game/Wall.scn")
	Actors["Player"] = load("res://Game/Player.scn")
	
	
	pass

func initalize_stage():
	players_life = 20