extends Node2D

var score = 0

@export var grid_size_x = 16
@export var grid_size_y = 16

const XP_PROGRESS_SIZE_MAX = 891

@onready var player = %Player
@onready var score_label = %ScoreLabel
@onready var xp_progress = %XPProgress
@onready var xp_label = %XPLabel
@onready var level_label = %LevelLabel
@onready var objects = $Objects

var units: Dictionary = {}
var enemy_units: Dictionary = {}

const TOWER = preload("res://scenes/tower.tscn")

func _ready() -> void:
	#get_tree().debug_collisions_hint = true
	
	for object in $Objects.get_children():
		if object is Unit:
			track_unit(object)
	
	var state_score = Config.get_value("player", "score")
	
	if state_score != null:
		score = int(state_score)
		update_score_label()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("cast_1"):
		if score > 10:
			update_coins(-10)
			
			var tower = TOWER.instantiate()
			
			tower.position = player.position
			
			add_unit(tower)
			

func add_unit(unit: Unit):
	track_unit(unit)
	objects.add_child(unit)
	
func track_unit(unit: Unit):
	units[unit.id] = unit
	
	if unit.is_enemy:
		enemy_units[unit.id] = unit
	
func remove_unit(unit: Unit):
	units.erase(unit.id)
	
	if unit.is_enemy:
		enemy_units.erase(unit.id)
		
	unit.queue_free()

func update_coins(add_coins: int):
	score += add_coins
	update_score_label()
	Config.set_value_and_save("player", "score", str(score))
	
func update_score_label():
	score_label.text = str(score) + " coins"

func update_xp():
	level_label.text = "Lv." + str(player.level)
	xp_label.text = str(player.xp) + " / " + str(player.xp_max)
	xp_progress.size.x = (float(player.xp) / float(player.xp_max)) * XP_PROGRESS_SIZE_MAX

func get_random_enemy():
	var unit: Unit = null
	var num_units = enemy_units.size()
	
	if num_units:
		var random_unit_index = randi_range(0, num_units - 1)
		var unit_values = enemy_units.values()
		
		unit = unit_values[random_unit_index]
		
	return unit
