extends Area2D

var is_pressed = false

func _ready():
	add_user_signal("player_pressed")	
	connect("body_enter", self, "on_body_enter")
	connect("body_exit", self, "on_body_exit")
	
	add_to_group("buttons")
	
	pass

func on_body_enter(body):
	if(body.get_name() == "Player"):
		is_pressed = true
		emit_signal("player_pressed")

func on_body_exit(body):
	if(body.get_name() == "Player"):
		is_pressed = false