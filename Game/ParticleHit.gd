
extends Particles2D

var lifetime = 0

func _ready():
	set_fixed_process(true)
	set_emitting(true)
	pass

func _fixed_process(delta):
	lifetime += delta
	if(lifetime > get_lifetime()):
		queue_free()
