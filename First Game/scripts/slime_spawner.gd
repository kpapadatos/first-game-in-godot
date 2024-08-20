extends Node2D

@export var interval_sec: float = 1

@onready var SLIME = preload("res://scenes/slime.tscn")
@onready var timer = $Timer

func _ready() -> void:
	timer.wait_time = interval_sec

func _on_timer_timeout() -> void:
	var slime = SLIME.instantiate()
	
	slime.position = position
	slime.speed *= 1 + (randf() * 0.3)
	
	get_parent().add_unit(slime)
