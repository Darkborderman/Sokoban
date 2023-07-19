class_name Goal
extends Area2D


var occupied = false


func _on_body_entered(body):
	if body.is_in_group('crate'):
		occupied = true



func _on_body_exited(body):
	if body.is_in_group('crate'):
		occupied = false
