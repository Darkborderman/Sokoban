class_name SelectScene
extends Node2D

const dir_path = "res://levels/"
const LevelCategory = preload("res://scenes/select/level_category.tscn")


func _ready():
	generate_data_packs(dir_path)


func generate_data_packs(path: String):
	var dir = DirAccess.open(path)
	if dir != null:
		for file_name in dir.get_files():
			create_level_items(dir_path,file_name)
	else:
		print("An error occurred when trying to access the path.")


func create_level_items(dir_path: String, file_name: String):
	var text = FileAccess.get_file_as_string(dir_path + file_name)
	var level_category: LevelCategory = LevelCategory.instantiate()
	var json = JSON.new()
	var error = json.parse(text)
	if error == OK:
		var data_received = json.data
		var index = Global.level_index
		var size = data_received.size()
		level_category.generate(file_name, size)
		$ScrollContainer/VBoxContainer.add_child(level_category)
