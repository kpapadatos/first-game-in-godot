extends Node2D

var color: Color = Color(1, 1, 1)

func _ready() -> void:
	var particles = $GPUParticles2D
	
	particles.emitting = true
	particles.process_material.color = color
	
	await particles.finished
	
	queue_free()
