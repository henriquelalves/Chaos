extends Area2D

export(float) var timer_limit = 3.0
var timer = 0.0

var life = 3

func _ready():
	# Initialization
	add_to_group("spawners")
	set_fixed_process(true)
	add_user_signal("spawn_timer")
	add_user_signal("spawn_dead")
	
	connect("area_enter",self,"on_body_enter")
	pass

func on_body_enter(body):
	if(body.get_name() == "Sword"):
		life -= 1
		if(life <= 0):
			emit_signal("spawn_dead")
			queue_free()

func _fixed_process(delta):
	
	timer += delta
	if(timer >= timer_limit):
		print("oiasdSDAS")
		timer -= timer_limit
		emit_signal("spawn_timer", get_global_pos())