extends TextureButton

@export
var pressed_action = ""

func _on_pressed():
	var action = InputEventAction.new()
	action.action = pressed_action
	Input.parse_input_event(action)
