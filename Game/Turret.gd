
extends StaticBody2D

export(Vector2) var bullets_direction = Vector2()
export(float) var timer_limit = 2.0
var timer = 0.0

func _ready():
	# Initialization here
	set_fixed_process(true)
	
	add_to_group("turrets")
	
	add_user_signal("turret_timer")
	
	pass

func _fixed_process(delta):
	timer += delta
	if(timer >= timer_limit):
		timer -= timer_limit
		emit_signal("turret_timer", get_global_pos(), bullets_direction)
