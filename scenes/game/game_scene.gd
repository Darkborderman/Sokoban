class_name GameScene
extends Node2D

var game_end = false;

var moves = 0
const Wall = preload("res://scenes/game/characters/wall.tscn")
const Player = preload("res://scenes/game/characters/player.tscn")
const Crate = preload("res://scenes/game/characters/crate.tscn")
const Goal = preload("res://scenes/game/characters/goal.tscn")


func read_level() -> String:
	var text = FileAccess.get_file_as_string("res://levels/level1.json")
	return text


func generate_level(level_data: Variant) -> void:
	# TODO: Add valid level validation
	var level = level_data[Global.level_index]
	$MarginContainer/VBoxContainer/LevelContainer/LevelLabel.text = "Level: " + str(Global.level_index + 1)
	Logger.info(level)
	Logger.info(level["name"])
	for item in level["walls"]:
		var wall: Wall = Wall.instantiate()
		$Walls.add_child(wall)
		wall.position.y = item[0] * 64
		wall.position.x = item[1] * 64
	for item in level["players"]:
		var player: Player = Player.instantiate()
		$Players.add_child(player)
		player.position.y = item[0] * 64
		player.position.x = item[1] * 64
		pass
	for item in level["crates"]:
		var crate = Crate.instantiate()
		$Crates.add_child(crate)
		crate.position.y = item[0] * 64
		crate.position.x = item[1] * 64
	for item in level["goals"]:
		var goal: Goal = Goal.instantiate()
		$Goals.add_child(goal)
		goal.position.y = item[0] * 64
		goal.position.x = item[1] * 64


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
		var size = data_received.size()
		if data_received.size() <= Global.level_index:
			get_tree().change_scene_to_file("res://scenes/entry_scene.tscn")
		else:
			generate_level(data_received)


func _process(_delta):
	$MarginContainer/VBoxContainer/MovesContainer/MovesLabel.text = "Moves: " + str(moves)
	$Players.get_child(0)  # TODO: handle with multiple children
	var goals = $Goals.get_child_count()
	for i in $Goals.get_children():
		if i.occupied:
			goals -=1
	if goals == 0:
		$ProceedButton.show()
