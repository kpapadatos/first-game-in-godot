extends Node2D

@export var interval_sec: float = 1

@onready var SLIME = preload("res://scenes/slime.tscn")
@onready var timer = $Timer

var total_spawned = 0

var spawn_hp = 3
var spawn_health_regeneration = 0

func _ready() -> void:
	timer.wait_time = interval_sec

func _on_timer_timeout() -> void:
	var slime: Unit = SLIME.instantiate()
	
	slime.target = get_parent().player.unit
	slime.position = position
	slime.movement_speed = 0.4 * (1 + (randf() * 0.3))
	slime.auto_melee_attack = true
	slime.hp = spawn_hp
	slime.hp_max = spawn_hp
	slime.health_regeneration = spawn_health_regeneration
	
	get_parent().add_unit(slime)
	
	total_spawned += 1
	
	if total_spawned % 10 == 0:
		spawn_hp += 1
		timer.wait_time = maxf(0.2, timer.wait_time * .95)
