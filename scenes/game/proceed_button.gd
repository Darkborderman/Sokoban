extends TextureButton


func _on_pressed():
	Global.level_index += 1
	# Redraw whole screen scenes
	get_tree().change_scene_to_file("res://scenes/game/game_scene.tscn")
