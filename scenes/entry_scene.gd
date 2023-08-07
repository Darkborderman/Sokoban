class_name EntryScene
extends Node2D


# Reset Global variables
func _ready():
	Global.level_pack_id = ""
	Global.level_index = 0

func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game_scene.tscn")
