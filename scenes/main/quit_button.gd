extends MarginContainer


func _ready():
	if OS.has_feature("web"):
		self.visible = false;


func _on_button_pressed():
	get_tree().quit()
