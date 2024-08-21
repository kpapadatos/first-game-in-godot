class_name Unit
extends Node2D

const COIN = preload("res://scenes/coin.tscn")
const HEALTHBAR = preload("res://scenes/unit_health_bar.tscn")
const PICKUP_RADIUS = preload("res://scenes/pickup_radius.tscn")
const FLOATING_TEXT = preload("res://scenes/floating_text_label.tscn")

var id = randi()
var target: Unit = null

@export var xp = 0
@export var xp_max = 100
@export var level = 1
@export var attack_speed = 2
@export var projectile_speed = 2
@export var hp: int = 1
@export var hp_max: int = 1
@export var pickup_radius = 0
@export var is_player = false
@export var movement_speed = 1
@export var melee_range = 10.0
@export var auto_melee_attack = false
@export var melee_attack_speed = 1.0
@export var melee_damage = 2.0
@export var health_regeneration = 0.0
@export var is_enemy = true

var healthbar = null
var pickup_radius_scene = null
var pos_override: Node2D = null
var melee_attack_timer: Timer = null
var health_regen_timer: Timer = null
var is_target_in_melee_range = false

func _ready() -> void:
	if pickup_radius > 0:
		pickup_radius_scene = PICKUP_RADIUS.instantiate()
		pickup_radius_scene.radius = pickup_radius
		pickup_radius_scene.unit = self
		add_child(pickup_radius_scene)
	
func _process(_delta: float) -> void:
	if hp < hp_max and healthbar == null:
		healthbar = HEALTHBAR.instantiate()
		
		add_child(healthbar)
	elif hp == hp_max and healthbar != null:
		healthbar.queue_free()
		healthbar = null
		
	if healthbar != null:
		healthbar.max_value = hp_max
		healthbar.value = hp
		
func _physics_process(_delta: float) -> void:
	is_target_in_melee_range = false
	
	if health_regeneration > 0.0 and hp < hp_max:
		schedule_health_regen()
	
	if !is_player and target != null:
		var distance = position.distance_to(target.get_pos())
		
		is_target_in_melee_range = distance <= melee_range
		
		if !is_target_in_melee_range:
			do_movement()
		elif auto_melee_attack:
			schedule_melee_attack()
			
func schedule_melee_attack():
	if melee_attack_timer == null:
		melee_attack_timer = Timer.new()
		melee_attack_timer.one_shot = true
		melee_attack_timer.autostart = true
		melee_attack_timer.wait_time = 1.0 / melee_attack_speed
		melee_attack_timer.connect("timeout", self._on_melee_attack_timer_timeout)
		add_child(melee_attack_timer)	
		
func schedule_health_regen():
	if health_regen_timer == null:
		health_regen_timer = Timer.new()
		health_regen_timer.one_shot = true
		health_regen_timer.autostart = true
		health_regen_timer.wait_time = 1.0 
		health_regen_timer.connect("timeout", self._on_health_regen_timer_timeout)
		add_child(health_regen_timer)

func _on_health_regen_timer_timeout():
	if hp < hp_max:
		heal(health_regeneration)
	
	health_regen_timer.queue_free()
	health_regen_timer = null
	
func heal(hp_to_heal: int):
	hp_to_heal = floori(hp_to_heal)
	
	hp = mini(hp_max, hp + hp_to_heal)
	
	float_text("+" + str(hp_to_heal), Color(0, 1, 0))
	
func _on_melee_attack_timer_timeout():
	if is_target_in_melee_range:
		target.do_damage(self, melee_damage)
	
	melee_attack_timer.queue_free()
	melee_attack_timer = null
			
func do_movement():
	position = position.move_toward(target.get_pos(), movement_speed)

func do_damage(actor: Unit, damage: int):
	hp -= damage
	
	if hp <= 0:
		die(actor)
	
	float_text(str(damage), Color(1, 0, 0) if is_player else Color(1, 1, 1))
	
func float_text(text: String, color: Color):
	var floating_text = FLOATING_TEXT.instantiate()
	
	floating_text.text = text
	
	floating_text.add_theme_color_override("font_color", color)
	
	add_child(floating_text)

func die(actor: Unit):
	if is_player:
		get_tree().reload_current_scene()
	else:
		var scene = get_tree().current_scene
		
		scene.remove_unit(self)
		
		var coin = COIN.instantiate()
		
		coin.position = position
		
		scene.objects.add_child(coin)
		
		actor.add_xp(20)
	
func add_xp(xp_to_add: int):
	xp += xp_to_add
	
	float_text("+" + str(xp_to_add) + " xp", Color(0, 0, 1))
	
	if xp >= xp_max:
		level += 1
		xp = xp - xp_max
		xp_max = roundf(float(xp_max) * 1.02)
		
		attack_speed += 0.1
		projectile_speed += 0.1
		
	if is_player:
		get_tree().current_scene.update_xp()

func get_pos():
	if pos_override:
		return pos_override.position
	else:
		return position

func get_projectile_origin():
	return $ProjectileOrigin if $ProjectileOrigin != null else self
