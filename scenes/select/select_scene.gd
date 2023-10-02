class_name SelectScene
extends Node2D


var LevelCategory = preload("res://scenes/select/level_category.tscn")


func _ready():
	for mod_pack in Global.level_data:
		for level_pack in Global.level_data[mod_pack].keys():
			var level_category = LevelCategory.instantiate()
			print(len(Global.level_data[mod_pack][level_pack]))
			level_category.generate(mod_pack, level_pack, len(Global.level_data[mod_pack][level_pack]))
			$ScrollContainer/VBoxContainer.add_child(level_category)
	return
