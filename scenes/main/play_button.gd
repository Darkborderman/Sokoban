extends MarginContainer


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/select/select_scene.tscn")
