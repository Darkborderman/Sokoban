class_name LevelCategory
extends Control

var LevelButton = preload("res://scenes/select/level_button.tscn")


func generate(mod_pack: String, label: String, level_count: int):
	$Label.text = label
	for i in level_count:
		var level_button = LevelButton.instantiate()
		level_button.generate(mod_pack, label, i)
		$ScrollContainer/HBoxContainer.add_child(level_button)
