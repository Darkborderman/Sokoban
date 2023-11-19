class_name Player
extends CharacterBody2D

var step_sounds = [
	preload("res://assets/footstep_grass_000.ogg"),
	preload("res://assets/footstep_grass_001.ogg"),
	preload("res://assets/footstep_grass_002.ogg"),
	preload("res://assets/footstep_grass_003.ogg"),
	preload("res://assets/footstep_grass_004.ogg"),
]

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

func play_sound():
	var index = randi() % step_sounds.size()
	$AudioStreamPlayer2D.stream = step_sounds[index]
	$AudioStreamPlayer2D.play()

func move(dir):
	Logger.info(dir)

	var vector_pos = inputs[dir] * GRID_SIZE
	ray.target_position = inputs[dir] * GRID_SIZE
	ray.force_raycast_update()
	if !ray.is_colliding():
		play_sound()
		position += vector_pos
		game.moves += 1
	else:
		var collider = ray.get_collider();
		print(collider.get_groups())
		if collider.is_in_group('crate'):
			if collider.move(dir):
				play_sound()
				position += vector_pos
				game.moves += 1
