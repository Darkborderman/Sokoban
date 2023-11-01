class_name Player
extends CharacterBody2D

@onready
var ray = $RayCast2D;
@onready
var game = get_parent().get_parent()

var GRID_SIZE = 64;
var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT,
};



func _input(event: InputEvent):
	# Physical keyboard
	if event is InputEventKey:
		for dir in inputs.keys():
			if event.is_action_pressed(dir):
				move(dir)
	# Texture button
	if event is InputEventAction:
		for dir in inputs.keys():
			if event.is_action(dir):
				move(dir)


func move(dir):
	Logger.info(dir)
	var vector_pos = inputs[dir] * GRID_SIZE
	ray.target_position = inputs[dir] * GRID_SIZE
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += vector_pos
		game.moves += 1
	else:
		var collider = ray.get_collider();
		print(collider.get_groups())
		if collider.is_in_group('crate'):
			if collider.move(dir):
				position += vector_pos
				game.moves += 1
