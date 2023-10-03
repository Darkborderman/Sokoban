class_name LevelButton
extends Control

@export var mod_pack_id: String = ""
@export var level_pack_id: String = ""
@export var level_index: int = 0


func generate(mod_pack: String, level_pack: String, index: int):
	mod_pack_id = mod_pack
	level_pack_id = level_pack
	level_index = index
	$Button.text = str(index + 1)


func _on_button_pressed():
	Global.mod_pack_id = mod_pack_id
	Global.level_pack_id = level_pack_id
	Global.level_index = int(level_index)
	get_tree().change_scene_to_file("res://scenes/game/game_scene.tscn")
