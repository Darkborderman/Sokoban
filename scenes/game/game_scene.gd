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
	# TODO: Add level proceed button switch judgement
	var level = level_data[0]
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


# Called when the node enters the scene tree for the first time.
func _ready():
	var json = JSON.new()
	var error = json.parse(read_level())
	if error == OK:
		var data_received = json.data
		generate_level(data_received)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$MarginContainer/VBoxContainer/MovesContainer/MovesLabel.text = "Moves: " + str(moves)
	$Players.get_child(0)  # TODO: handle with multiple children
	var goals = $Goals.get_child_count()
	for i in $Goals.get_children():
		if i.occupied:
			goals -=1
	if goals == 0 and game_end == false:
		$ProceedButton.show()
		game_end = true
