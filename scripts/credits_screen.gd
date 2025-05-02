extends Node2D


func _on_exit_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/start_screen.tscn")
