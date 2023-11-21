class_name MainScene
extends Node2D

var vanilla_path = "res://levels/"
var mod_path = ""


func create_level_data(file_path: String):
	var text = FileAccess.get_file_as_string(file_path)
	var json = JSON.new()
	var error = json.parse(text)
	if error == OK:
		var data_received = json.data
		return [data_received["name"], data_received["levels"]]
	else:
		return []


func generate_data_packs(root_path: String):
	var dir = DirAccess.open(root_path)
	if dir != null:
		# iterate mod folder
		for dir_name in dir.get_directories():
			Global.level_data[dir_name] = {}
			var subdir = DirAccess.open(root_path + dir_name)
			if subdir != null:
				# iterate level data
				for file_name in subdir.get_files():
					var result = create_level_data(root_path + dir_name  + "/" + file_name)
					if len(result) != 0:
						var level_name = result[0]
						var level_data = result[1]
						Global.level_data[dir_name][level_name] = level_data
	else:
		print("An error occurred when trying to access the path.")


# Reset Global variables
func _ready():
	Global.level_pack_id = ""
	Global.level_index = 0
	Global.level_data = {}
	Global.init_save_data()
	generate_data_packs(vanilla_path)
