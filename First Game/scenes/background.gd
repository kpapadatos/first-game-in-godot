extends TileMapLayer

@onready var game_manager = %GameManager

const TILE_SET = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear()
	
	for x in range(0, game_manager.grid_size_x):
		for y in range(0, game_manager.grid_size_y):
			set_cell(Vector2i(x, y), TILE_SET, Vector2i(x % 2, y % 2), 0)
