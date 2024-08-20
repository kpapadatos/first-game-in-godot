extends Area2D

@onready var animation_player = $AnimationPlayer

var body_to_follow: Node2D = null

func _physics_process(_delta: float) -> void:
	if body_to_follow:
		position = position.move_toward(body_to_follow.get_pos(), 1)

func attract(body: Node2D):
	body_to_follow = body

func _on_body_entered(body):
	body_to_follow = body
	
	get_tree().current_scene.add_point()
	animation_player.play("pickup")
