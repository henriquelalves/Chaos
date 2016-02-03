
extends KinematicBody2D

# Movement variables
var target_pos = Vector2()
var speed = 1
var life = 3

var global

# Knockback
var is_knockback = false
var knockback_direction = Vector2()

# Public functions

func set_target(players_pos):
	target_pos = Vector2(0,0)
	for p in players_pos:
		if target_pos == Vector2(0,0):
			target_pos = p
		else:
			if ((get_global_pos() - target_pos).length() > (get_global_pos() - p).length()):
				target_pos = p

func knockback(var from_pos, var strength):
	knockback_direction = Vector2(get_global_pos() - from_pos).normalized()*strength
	is_knockback = true

# Private functions
func _ready():
	global = get_node("/root/global")
	
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
		# Neat particle effect for playerfeedback
		var particleEffect = global.Actors["ParticleHit"].instance()
		get_parent().add_child(particleEffect)
		particleEffect.set_color(Color(0,255,0))
		particleEffect.set_global_pos(get_global_pos())
		print(particleEffect.is_emitting())
		# Knockback movement
		direction = knockback_direction
		is_knockback = false
	
	move(direction)
