extends TileMapLayer

const TILE_SET = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scene = get_tree().current_scene
	
	clear()
	
	for x in range(0, scene.grid_size_x):
		for y in range(0, scene.grid_size_y):
			set_cell(Vector2i(x, y), TILE_SET, Vector2i(x % 2, y % 2), 0)
