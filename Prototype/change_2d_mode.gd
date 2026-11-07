extends Node

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_2):
		get_tree().change_scene_to_file("res://Prototype/empty2.tscn")
	if Input.is_key_pressed(KEY_1):
		get_tree().change_scene_to_file("res://Prototype/empty.tscn")
