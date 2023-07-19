class_name MainScene
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load entry screen
	get_tree().change_scene_to_file("res://scenes/entry_scene.tscn")
