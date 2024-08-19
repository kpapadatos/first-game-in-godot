class_name Unit
extends Node2D

const COIN = preload("res://scenes/coin.tscn")

var id = randi()

func die():
	var scene = get_tree().current_scene
	
	scene.remove_unit(self)
	
	var coin = COIN.instantiate()
	
	coin.position = position
	
	scene.objects.add_child(coin)
	scene.add_xp(20)
