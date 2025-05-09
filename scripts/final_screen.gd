extends Node2D

@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var next_scene_path: String = "res://ui/start_screen.tscn"
@export var sound_path: String = "res://sounds/victoryMusic.mp3"

func _ready() -> void:
	color_rect.visible = false
	label.visible = false

	var timer = get_tree().create_timer(5.0)
	timer.timeout.connect(_on_timer_timeout)
	if sound_path != "":
		var sound = load(sound_path)
		if sound:
			audio_player.stream = sound
	if audio_player.stream:
		audio_player.play()

func _on_timer_timeout() -> void:
	color_rect.visible = true
	label.visible = true

func _input(event: InputEvent) -> void:
	if color_rect.visible and event.is_pressed():
		change_to_next_scene()

func change_to_next_scene() -> void:
	if next_scene_path != "":
		get_tree().change_scene_to_file(next_scene_path)
