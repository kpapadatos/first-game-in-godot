class_name Unit
extends Node2D

const COIN = preload("res://scenes/coin.tscn")
const HEALTHBAR = preload("res://scenes/unit_health_bar.tscn")

var id = randi()
@export var xp = 0
@export var xp_max = 100
@export var level = 1
@export var attack_speed = 2
@export var projectile_speed = 2
var target = null
@export var hp = 1
@export var hp_max = 1

var healthbar = null

func _process(_delta):
	if hp < hp_max and healthbar == null:
		healthbar = HEALTHBAR.instantiate()
		
		add_child(healthbar)
	elif hp == hp_max and healthbar != null:
		healthbar.queue_free()
		healthbar = null
		
	if healthbar != null:
		healthbar.max = hp_max
		healthbar.value = hp

func do_damage(damage: int):
	hp -= damage
	
	print(self.name + " took " + str(damage) + " damage")
	
	if hp <= 0:
		die()

func die():
	var scene = get_tree().current_scene
	
	scene.remove_unit(self)
	
	var coin = COIN.instantiate()
	
	coin.position = position
	
	scene.objects.add_child(coin)
	scene.add_xp(20)
	
func add_xp(add_xp: int):
	xp += add_xp
	
	if xp >= xp_max:
		level += 1
		xp = xp - xp_max
		xp_max = roundf(float(xp_max) * 1.02)
		
		attack_speed += 0.1
		projectile_speed += 0.1
		
