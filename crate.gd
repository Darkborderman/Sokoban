class_name Crate
extends CharacterBody2D


@onready
var ray = $RayCast2D;

var GRID_SIZE = 64;
var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT,
};



func move(dir):
	var vector_pos = inputs[dir] * GRID_SIZE
	ray.target_position = inputs[dir] * GRID_SIZE
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += vector_pos
		return true
	return false
