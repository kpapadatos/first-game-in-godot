extends Node

var config_file = ConfigFile.new()
var file_name = "user://state.cfg"

func _ready() -> void:
	config_file.load(file_name)

func get_value(section: String, key: String):
	return config_file.get_value(section, key)

func set_value(section: String, key: String, value: String):
	config_file.set_value(section, key, value)
	
func set_value_and_save(section: String, key: String, value: String):
	set_value(section, key, value)
	save()

func save():
	config_file.save(file_name)
