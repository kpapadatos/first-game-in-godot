extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = $AnimatedSprite2D

var target: Node2D

func _physics_process(_delta):
	do_movement()
	
	var units = get_parent().get_parent().units
	var num_units = units.size()
	
	if num_units:
		var random_unit_index = randi_range(0, num_units - 1)
		var unit_values = units.values()
		
		print("tar idx " + str(random_unit_index) + " of " + str(unit_values.size()))
		
		target = units.values()[random_unit_index]
	else:
		target = null

func do_movement():
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	var ydirection = Input.get_axis("move_up", "move_down")
	
	# Flip the Sprite
	if direction > 0:
		direction = 1
		animated_sprite.flip_h = false
	elif direction < 0:
		direction = -1
		animated_sprite.flip_h = true
		
	if ydirection > 0:
		ydirection = 1
	elif ydirection < 0:
		ydirection = -1
	
	if direction == 0 and ydirection == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
		
	var speed = SPEED
	
	if(direction and ydirection):
		speed /= 1.4
	
	# Apply movement
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if ydirection:
		velocity.y = ydirection * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
