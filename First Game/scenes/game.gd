extends Node2D

var score = 0
var xp = 0
var xp_max = 100
var level = 1

@export var player: Node2D

const XP_PROGRESS_SIZE_MAX = 891

@onready var score_label = %ScoreLabel
@onready var xp_progress = %XPProgress
@onready var xp_label = %XPLabel
@onready var objects = $Objects

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
	xp_label.text = str(xp) + " / " + str(xp_max)
	xp_progress.size.x = (float(xp) / float(xp_max)) * XP_PROGRESS_SIZE_MAX
	
	if xp >= xp_max:
		level += 1
		xp = xp - xp_max
		xp_max *= 1.02
