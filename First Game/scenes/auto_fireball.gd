extends Timer

const FIREBALL = preload("res://scenes/fireball.tscn")

@onready var unit: Unit = get_parent()

func _physics_process(_delta: float) -> void:
	wait_time = 1.0 / unit.attack_speed

func _on_timeout() -> void:
	var scene = get_tree().current_scene
	var target = scene.get_random_enemy()
	
	if target != null:
		var fireball = FIREBALL.instantiate()
		
		fireball.position = unit.position + unit.get_projectile_origin()
		
		fireball.speed = unit.projectile_speed / 1.0
		fireball.target = target
		fireball.actor = unit
		
		scene.add_child(fireball)
