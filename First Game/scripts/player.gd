extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var unit = $Unit

func _ready() -> void:
	unit.pos_override = self

func _physics_process(_delta):
	do_movement()

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
		
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * SPEED
	
	move_and_slide()

func get_pos():
	return position
