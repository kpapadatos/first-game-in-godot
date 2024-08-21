extends Node2D

@export var interval_sec: float = 1

@onready var SLIME = preload("res://scenes/slime.tscn")
@onready var timer = $Timer

func _ready() -> void:
	timer.wait_time = interval_sec

func _on_timer_timeout() -> void:
	var slime = SLIME.instantiate()
	
	slime.target = get_parent().player.unit
	slime.position = position
	slime.movement_speed = 0.4 * (1 + (randf() * 0.3))
	slime.auto_melee_attack = true
	
	get_parent().add_unit(slime)
