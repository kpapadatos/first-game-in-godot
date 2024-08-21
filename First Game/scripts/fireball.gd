extends Node2D

@export var speed: float
@export var target: Node2D

var last_known_target_pos: Vector2
var actor: Unit

func _physics_process(_delta) -> void:
	var target_pos: Vector2
	
	if is_instance_valid(target):
		last_known_target_pos = target.position
		target_pos = target.position
	else:
		target_pos = last_known_target_pos
	
	if target_pos:
		position = position.move_toward(target_pos, speed)
		
		if position.distance_to(target_pos) < 1:
			queue_free()
			
			if is_instance_valid(target):
				target.do_damage(actor, 1)	
	else:
		queue_free()
