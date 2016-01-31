
extends KinematicBody2D

# Movement variables
var target_pos = Vector2()
var speed = 1
var life = 3

# Knockback
var is_knockback = false
var knockback_direction = Vector2()


# Public functions

func set_target(new_t):
	target_pos = new_t

func knockback(var from_pos, var strength):
	knockback_direction = Vector2(get_global_pos() - from_pos).normalized()*strength
	is_knockback = true

# Private functions
func _ready():
	set_fixed_process(true)
	get_node("EnemyArea").connect("area_enter", self, "on_area_enter")
	
	add_to_group("enemies")
	
	pass

func on_area_enter(area):
	if(area.get_name() == "Sword"):
		knockback(area.get_global_pos(), 30)
		life -= 1
		if(life <= 0):
			queue_free()

# update
func _fixed_process(delta):
	var direction
	
	if(is_knockback == false):
		var current_pos = get_pos()
		direction = Vector2(target_pos - current_pos)
		direction = direction.normalized()*speed
	else:
		direction = knockback_direction
		is_knockback = false
	
	move(direction)
