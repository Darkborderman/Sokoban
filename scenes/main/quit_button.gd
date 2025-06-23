extends MarginContainer


func _on_button_pressed():
	get_tree().quit()
	if OS.has_feature("web"):
		# OPTIONAL: ask JS to close the tab (works only if the tab was script-opened)
		JavaScriptBridge.eval("window.close();")  # requires the JavaScriptBridge singleton
