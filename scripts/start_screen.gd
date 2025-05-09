extends Node2D

@export var sound_path: String = "res://sounds/startMusic.mp3"
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	if sound_path != "":
		var sound = load(sound_path)
		if sound:
			audio_player.stream = sound
	if audio_player.stream:
		audio_player.play()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels//world_1.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui//credits_screen.tscn")
