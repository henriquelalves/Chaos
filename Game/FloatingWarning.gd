
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var timer_limit = 2.0
var timer = 0.0

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	timer += delta
	set_pos(get_pos() + Vector2(0,-0.4))
	
	set_scale(get_scale() + Vector2(0.002,0.002))
	
	if(timer >= timer_limit):
		queue_free()