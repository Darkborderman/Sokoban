class_name GameScene
extends Node2D

var game_end = false;

var moves = 0
const Wall = preload("res://scenes/game/characters/wall.tscn")
const Player = preload("res://scenes/game/characters/player.tscn")
const Crate = preload("res://scenes/game/characters/crate.tscn")
const Goal = preload("res://scenes/game/characters/goal.tscn")


func read_level() -> String:
	var text = FileAccess.get_file_as_string("res://levels/" + Global.level_pack_id)
	return text


func generate_level(level_data: Variant) -> void:
	# TODO: Add valid level validation
	$MarginContainer/VBoxContainer/LevelContainer/LevelLabel.text = "Level: " + str(Global.level_index + 1)

	var row_index: int = 0
	var char_index: int = 0
	for row in level_data:
		char_index = 0
		for char in row:
			if char == ".":
				pass
			if char == "#":
				var wall: Wall = Wall.instantiate()
				$Walls.add_child(wall)
				wall.position.x = char_index * 64
				wall.position.y = row_index * 64
			if char == "@" or char == "A":
				var player: Player = Player.instantiate()
				$Players.add_child(player)
				player.position.x = char_index * 64
				player.position.y = row_index * 64
			if char == "X" or char == "C":
				var crate = Crate.instantiate()
				$Crates.add_child(crate)
				crate.position.x = char_index * 64
				crate.position.y = row_index * 64
			if char == "O" or char == "C":
				var goal: Goal = Goal.instantiate()
				$Goals.add_child(goal)
				goal.position.x = char_index * 64
				goal.position.y = row_index * 64
			char_index += 1
		row_index+= 1


func cleanup_level(node: Node) -> void:
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()


func _ready():
	var json = JSON.new()
	var error = json.parse(read_level())
	if error == OK:
		var data_received = json.data
		var index = Global.level_index
		var level_count = data_received["levels"].size()
		if level_count <= Global.level_index:
			get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
		else:
			generate_level(data_received["levels"][Global.level_index])


func _process(_delta):
	$MarginContainer/VBoxContainer/MovesContainer/MovesLabel.text = "Moves: " + str(moves)
	$Players.get_child(0)  # TODO: handle with multiple children
	var goals = $Goals.get_child_count()
	for i in $Goals.get_children():
		if i.occupied:
			goals -=1
	if goals == 0:
		$ProceedButton.show()
