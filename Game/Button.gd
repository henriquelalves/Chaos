extends Area2D

var is_pressed = false

var player_name

var global

func _ready():
	global = get_node("/root/global")
	add_user_signal("player_pressed")	
	connect("body_enter", self, "on_body_enter")
	connect("body_exit", self, "on_body_exit")
	
	add_to_group("buttons")
	
	pass

func on_body_enter(body):
	if(body.is_in_group("players")):
		if(player_name == null or (player_name == body.get_name())):
			player_name = body.get_name()
			is_pressed = true
			emit_signal("player_pressed")
		else:
			var label = global.Actors["FloatingWarning"].instance()
			add_child(label)

func on_body_exit(body):
	if(body.get_name() == "Player"):
		is_pressed = false