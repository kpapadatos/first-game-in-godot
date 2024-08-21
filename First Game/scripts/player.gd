extends Unit

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	xp = 0
	xp_max = 100
	level = 1
	attack_speed = 2.0
	projectile_speed = 2.0
	hp = 100
	hp_max = 100
	pickup_radius = 30.0
	is_player = true
	movement_speed = 130.0
	melee_range = 0.0
	auto_melee_attack = false
	melee_attack_speed = 0.0
	melee_damage = 0.0
	health_regeneration = 1.0
	is_enemy = false
	
	super._ready()

func _physics_process(_delta):
	do_movement()
	
	super._physics_process(_delta)

func do_movement():
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	var ydirection = Input.get_axis("move_up", "move_down")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if direction == 0 and ydirection == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * movement_speed
	
	move_and_slide()
