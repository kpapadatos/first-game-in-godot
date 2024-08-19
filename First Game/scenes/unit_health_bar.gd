extends Node2D

var max = 1
var value = 1

@onready var bg = $Background
@onready var fg = $Foreground

func _process(_delta: float) -> void:
	fg.size.x = (float(value) / float(max)) * bg.size.x
