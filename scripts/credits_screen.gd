extends Node2D

@onready var voltar_button = $ExitCreditsButton
var bola_ja_apertado = false

func _ready() -> void:
	voltar_button.grab_focus()

func _process(_delta: float) -> void:
	var bola_pressionado = Input.is_joy_button_pressed(0, JOY_BUTTON_B)

	if bola_pressionado and not bola_ja_apertado:
		voltar_button.pressed.emit()

	bola_ja_apertado = bola_pressionado

func _on_exit_credits_button_pressed() -> void:
	LoadManager.load_scene("res://ui/start_screen.tscn")
