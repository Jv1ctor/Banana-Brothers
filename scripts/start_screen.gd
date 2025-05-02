extends Node2D


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels//world_1.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui//credits_screen.tscn")
