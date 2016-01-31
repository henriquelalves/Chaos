extends Area2D

var direction = Vector2()
var global
func _ready():
	set_fixed_process(true)
	
	global = get_node("/root/global")
	
	connect("body_enter",self,"on_body_enter")
	pass

func _fixed_process(delta):
	set_global_pos(get_global_pos() + direction)

func set_direction(v):
	direction = v

func on_body_enter(body):
	if(body.is_in_group("players") or body.is_in_group("walls")):
		queue_free()