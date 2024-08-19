extends Node

var score = 0

@onready var player = %Player
@onready var score_label = $ScoreLabel
@onready var game = $".."

@export var grid_size_x = 16
@export var grid_size_y = 16

const FIREBALL = preload("res://fireball.tscn")

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."


func _on_fireball_timer_timeout() -> void:
	if player.target:
		var fireball = FIREBALL.instantiate()
		
		fireball.position = player.position
		
		fireball.speed = 1
		fireball.target = player.target
		
		game.add_child(fireball)
