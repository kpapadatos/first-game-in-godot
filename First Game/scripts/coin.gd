extends Area2D

@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	get_tree().current_scene.add_point()
	animation_player.play("pickup")
