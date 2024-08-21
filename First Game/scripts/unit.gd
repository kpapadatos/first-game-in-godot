class_name Unit
extends Node2D

const COIN = preload("res://scenes/coin.tscn")
const HEALTHBAR = preload("res://scenes/unit_health_bar.tscn")
const PICKUP_RADIUS = preload("res://scenes/pickup_radius.tscn")
const FLOATING_TEXT = preload("res://scenes/floating_text_label.tscn")

var id = randi()
@export var xp = 0
@export var xp_max = 100
@export var level = 1
@export var attack_speed = 2
@export var projectile_speed = 2
var target: Node2D = null
@export var hp = 1
@export var hp_max = 1
@export var pickup_radius = 0
@export var is_player = false

var healthbar = null
var pickup_radius_scene = null
var pos_override: Node2D = null

func _ready() -> void:
	if pickup_radius > 0:
		pickup_radius_scene = PICKUP_RADIUS.instantiate()
		pickup_radius_scene.radius = pickup_radius
		pickup_radius_scene.unit = self
		add_child(pickup_radius_scene)
	
func _process(delta: float) -> void:
	if hp < hp_max and healthbar == null:
		healthbar = HEALTHBAR.instantiate()
		
		add_child(healthbar)
	elif hp == hp_max and healthbar != null:
		healthbar.queue_free()
		healthbar = null
		
	if healthbar != null:
		healthbar.max_value = hp_max
		healthbar.value = hp
		
func _physics_process(delta: float) -> void:
	pass

func do_damage(damage: int):
	hp -= damage
	
	if hp <= 0:
		die()
		
	var floating_text = FLOATING_TEXT.instantiate()
	
	floating_text.text = str(damage)
	floating_text.add_theme_color_override("font_color", Color(1, 1, 1))
	
	add_child(floating_text)

func die():
	var scene = get_tree().current_scene
	
	scene.remove_unit(self)
	
	var coin = COIN.instantiate()
	
	coin.position = position
	
	scene.objects.add_child(coin)
	scene.add_xp(20)
	
func add_xp(xp_to_add: int):
	xp += xp_to_add
	
	if xp >= xp_max:
		level += 1
		xp = xp - xp_max
		xp_max = roundf(float(xp_max) * 1.02)
		
		attack_speed += 0.1
		projectile_speed += 0.1
		
func get_pos():
	if pos_override:
		return pos_override.position
	else:
		return position
