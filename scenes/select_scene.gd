extends Node2D

var dir_path = "res://levels/"

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_data_packs(dir_path)
	pass # Replace with function body.


func generate_data_packs(path: String):	
	var dir = DirAccess.open(path)
	if dir != null:
		for file_name in dir.get_files():
			print(file_name)
			# create_level_btn('%s/%s' % [dir.get_current_dir(), file_name], file_name)
	else:
		print("An error occurred when trying to access the path.")
	pass
	
