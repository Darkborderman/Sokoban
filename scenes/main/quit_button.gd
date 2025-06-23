extends MarginContainer


func _on_button_pressed():
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()

	if OS.has_feature("web") and JavaScriptBridge.has_method("eval"):
		JavaScriptBridge.eval("window.close();")
