extends Node2D

var score = 0
var xp = 0
var xp_max = 100
var level = 1
var attack_speed = 1
var projectile_speed = 1

@export var player: Node2D
@export var grid_size_x = 16
@export var grid_size_y = 16

const XP_PROGRESS_SIZE_MAX = 891
const FIREBALL = preload("res://fireball.tscn")

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
	xp += add_xp
	
	if xp >= xp_max:
		level += 1
		xp = xp - xp_max
		xp_max = roundf(float(xp_max) * 1.02)
		
		attack_speed += 0.1
		projectile_speed += 0.1
		
		fireball_timer.wait_time = 1 / attack_speed
		
	level_label.text = "Lv." + str(level)
	xp_label.text = str(xp) + " / " + str(xp_max)
	xp_progress.size.x = (float(xp) / float(xp_max)) * XP_PROGRESS_SIZE_MAX
	
func _on_fireball_timer_timeout() -> void:
	if player.target:
		var fireball = FIREBALL.instantiate()
		
		fireball.position = player.position
		
		fireball.speed = projectile_speed / 1
		fireball.target = player.target
		
		print("fireball to " + fireball.target.name)
		
		add_child(fireball)
