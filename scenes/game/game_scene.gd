class_name GameScene
extends Node2D

var level_completed = false;

var Wall = preload("res://scenes/game/characters/wall.tscn")
var Player = preload("res://scenes/game/characters/player.tscn")
var Crate = preload("res://scenes/game/characters/crate.tscn")
var Goal = preload("res://scenes/game/characters/goal.tscn")
var complete_sound = preload("res://assets/jingles_PIZZI16.ogg")


func cleanup_children(node: Node) -> void:
	# Release node's children
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()


func generate_level(level_data: Variant) -> void:
	var best_moves = Global.get_best_record()
	if best_moves <= 0:
		best_moves = ""
	$MarginContainer/HBoxContainer/VBoxContainer/BestMovesContainer/BestMovesLabel.text = "Best Moves: " + str(best_moves)
	$MarginContainer/HBoxContainer/VBoxContainer/LevelContainer/LevelLabel.text = "Level: " + str(Global.level_index + 1)

	# Cleanup stale level data
	cleanup_children($Walls)
	cleanup_children($Players)
	cleanup_children($Crates)
	cleanup_children($Goals)
	Global.current_level_moves = 0
	level_completed = false

	# TODO: Add valid level validation
	var row_index: int = 0
	var char_index: int = 0
	for row in level_data:
		char_index = 0
		for char in row:
			if char == ".":
				pass
			if char == "#":
				var wall = Wall.instantiate()
				$Walls.add_child(wall)
				wall.position.x = char_index * 64
				wall.position.y = row_index * 64
			if char == "@" or char == "A":
				var player = Player.instantiate()
				$Players.add_child(player)
				player.position.x = char_index * 64
				player.position.y = row_index * 64
			if char == "X" or char == "C":
				var crate = Crate.instantiate()
				$Crates.add_child(crate)
				crate.position.x = char_index * 64
				crate.position.y = row_index * 64
			if char == "O" or char == "C":
				var goal = Goal.instantiate()
				$Goals.add_child(goal)
				goal.position.x = char_index * 64
				goal.position.y = row_index * 64
			char_index += 1
		row_index+= 1


func complete() -> void:
	Global.save_best_record(Global.current_level_moves)
	$MarginContainer2/HBoxContainer/VBoxContainer2/MarginContainer3.show()
	$AudioStreamPlayer2D.stream = complete_sound
	$AudioStreamPlayer2D.play()
	level_completed = true


func _ready():
	if len(Global.level_data[Global.mod_pack_id][Global.level_pack_id]) <= Global.level_index:
		# All level solved, return to main scene
		get_tree().change_scene_to_file.bind("res://scenes/main/main_scene.tscn").call_deferred()
	else:
		generate_level(Global.level_data[Global.mod_pack_id][Global.level_pack_id][Global.level_index])


func _process(_delta):
	$MarginContainer/HBoxContainer/VBoxContainer/MovesContainer/MovesLabel.text = "Moves: " + str(Global.current_level_moves)
	var goals = $Goals.get_child_count()
	for i in $Goals.get_children():
		if i.occupied:
			goals -=1
	if goals == 0 and level_completed == false:
		complete()


func _input(event: InputEvent):
	# Physical keyboard
	if event is InputEventKey:
			if event.is_action_pressed('ui_reset_level'):
				generate_level(Global.level_data[Global.mod_pack_id][Global.level_pack_id][Global.level_index])
