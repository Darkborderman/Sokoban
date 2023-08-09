class_name LevelButton
extends Control

@export var level_pack_id: String = ""
@export var level_index: int = 0


func generate(level_id: String ,index_count: int):
	level_index = index_count
	level_pack_id = level_id
	$Button.text = str(level_index)


func _on_button_pressed():
	Global.level_index = int($Button.text)
	Global.level_pack_id = level_pack_id
	get_tree().change_scene_to_file("res://scenes/game/game_scene.tscn")
