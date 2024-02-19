extends TextureButton


func _on_pressed():
	pass
	get_tree().current_scene.generate_level(Global.level_data[Global.mod_pack_id][Global.level_pack_id][Global.level_index])
	#.generate_level(Global.level_data[Global.mod_pack_id][Global.level_pack_id][Global.level_index])
