extends Node2D

var score = 0

@export var grid_size_x = 16
@export var grid_size_y = 16

const XP_PROGRESS_SIZE_MAX = 891
const FIREBALL = preload("res://fireball.tscn")

@onready var player = %Player
@onready var score_label = %ScoreLabel
@onready var xp_progress = %XPProgress
@onready var xp_label = %XPLabel
@onready var level_label = %LevelLabel
@onready var objects = $Objects
@onready var fireball_timer = %FireballTimer

var units: Dictionary = {}

func add_unit(unit: Unit):
	units[unit.id] = unit
	objects.add_child(unit)
	
func remove_unit(unit: Unit):
	units.erase(unit.id)
	unit.queue_free()

func add_point():
	score += 1
	score_label.text = str(score) + " coins"
	
func add_xp(add_xp: int):
	player.unit.add_xp(add_xp)
		
	fireball_timer.wait_time = 1 / player.unit.attack_speed
	level_label.text = "Lv." + str(player.unit.level)
	xp_label.text = str(player.unit.xp) + " / " + str(player.unit.xp_max)
	xp_progress.size.x = (float(player.unit.xp) / float(player.unit.xp_max)) * XP_PROGRESS_SIZE_MAX
	
func _on_fireball_timer_timeout() -> void:
	if player.unit.target != null:
		var fireball = FIREBALL.instantiate()
		
		fireball.position = player.position
		
		fireball.speed = player.unit.projectile_speed / 1
		fireball.target = player.unit.target
		
		add_child(fireball)
