extends AudioStreamPlayer2D

var is_enabled = false

func _ready() -> void:
	set_enabled(Config.get_value("settings", "music_enabled") == "true")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_music"):
		toggle()
		
		Config.set_value_and_save("settings", "music_enabled", str(is_enabled))
		
func set_enabled(state: bool):
	is_enabled = state
	
	if is_enabled:
		Music.play()
	else:
		Music.stop()

func toggle():
	set_enabled(!is_enabled)
