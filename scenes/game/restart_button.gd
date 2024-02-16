extends TextureButton


func _on_pressed():
	get_parent().generate_level(Global.level_data[Global.mod_pack_id][Global.level_pack_id][Global.level_index])
