extends Node

@onready var collision_shape = %PickupCollisionShape2D

var unit: Unit
var radius = 0

func _ready() -> void:
	collision_shape.shape.radius = radius

func _on_area_shape_entered(_area_rid: RID, item: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	item.attract(unit)
