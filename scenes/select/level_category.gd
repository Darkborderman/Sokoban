class_name LevelCategory
extends Control

const LevelButton = preload("res://scenes/select/level_button.tscn")


func generate(label: String, index_count: int):
	$Label.text = label
	for i in index_count:
		var level_button = LevelButton.instantiate()
		level_button.generate(i)
		$ScrollContainer/HBoxContainer.add_child(level_button)
