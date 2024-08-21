extends Timer

const FIREBALL = preload("res://scenes/fireball.tscn")

@onready var unit: Unit = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	wait_time = 1 / unit.attack_speed

func _on_timeout() -> void:
	var scene = get_tree().current_scene
	var target = scene.get_random_enemy()
	
	if target != null:
		var fireball = FIREBALL.instantiate()
		
		fireball.position = unit.get_pos() + unit.get_projectile_origin().position
		
		fireball.speed = unit.projectile_speed / 1
		fireball.target = target
		fireball.actor = unit
		
		scene.add_child(fireball)
