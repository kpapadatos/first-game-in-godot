extends TileMapLayer

@onready var game_manager = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var data = tile_map_data
	var tset = tile_set
	var user_cells = get_used_cells()
	
	clear()
	
	const TILE_SET = 1
	
	for x in range(0, game_manager.grid_size_x):
		for y in range(0, game_manager.grid_size_y):
			set_cell(Vector2i(x, y), TILE_SET, Vector2i(x % 2, y % 2), 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
