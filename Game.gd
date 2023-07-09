extends Node2D

var game_end = false;
var moves = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$MovesLabel.text = "Moves" + str(moves)
	var goals = $Goals.get_child_count()
	for i in $Goals.get_children():
		if i.occupied:
			goals -=1
	if goals == 0 and game_end == false:
		$AcceptDialog.popup()
		game_end = true
