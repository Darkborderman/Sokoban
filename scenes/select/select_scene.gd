extends Node2D

var dir_path = "res://levels/"


func _ready():
	generate_data_packs(dir_path)


func generate_data_packs(path: String):	
	var dir = DirAccess.open(path)
	if dir != null:
		for file_name in dir.get_files():
			print(file_name)
			create_level_items(dir_path + file_name)
	else:
		print("An error occurred when trying to access the path.")

func create_level_items(path):
	var text = FileAccess.get_file_as_string(path)
	pass

func read_level() -> String:
	var text = FileAccess.get_file_as_string("res://levels/level1.json")
	return text
