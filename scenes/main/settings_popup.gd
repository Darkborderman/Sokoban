extends PopupPanel


func _on_reset_button_pressed():
	Global.init_save_data(true)
	self.hide()
