extends Node2D

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var sound_path: String = "res://sounds/startMusic.mp3"

@onready var start_button = $StartButton
@onready var credits_button = $CreditsButton
@onready var exit_button = $ExitButton

var posicao_vertical = 0  # 0 = cima ("Jogar"), 1 = baixo ("Créditos/Sair")
var posicao_horizontal = 0  # 0 = esquerda ("Créditos"), 1 = direita ("Sair")

var cooldown = 0.2
var tempo_espera = 0.0

func _ready() -> void:
	if sound_path != "":
		var sound = load(sound_path)
		if sound:
			audio_player.stream = sound
	if audio_player.stream:
		audio_player.play()

	# Foco inicial no botão "Jogar"
	start_button.grab_focus()

func _process(delta: float) -> void:
	if tempo_espera > 0:
		tempo_espera -= delta
		return

	# Navegação analógica
	var eixo_y = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
	var eixo_x = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)

	if eixo_y < -0.5:
		mover_vertical(-1)
	elif eixo_y > 0.5:
		mover_vertical(1)
	elif eixo_x < -0.5 and posicao_vertical == 1:
		mover_horizontal(-1)
	elif eixo_x > 0.5 and posicao_vertical == 1:
		mover_horizontal(1)

	# Botão X do controle PS4 (JOY_BUTTON_A = 1)
	if Input.is_joy_button_pressed(0, JOY_BUTTON_A):
		executar_botao()

func mover_vertical(direcao: int) -> void:
	posicao_vertical = clamp(posicao_vertical + direcao, 0, 1)

	if posicao_vertical == 0:
		start_button.grab_focus()
	else:
		if posicao_horizontal == 0:
			credits_button.grab_focus()
		else:
			exit_button.grab_focus()

	tempo_espera = cooldown

func mover_horizontal(direcao: int) -> void:
	posicao_horizontal = clamp(posicao_horizontal + direcao, 0, 1)

	if posicao_horizontal == 0:
		credits_button.grab_focus()
	else:
		exit_button.grab_focus()

	tempo_espera = cooldown

func executar_botao():
	if posicao_vertical == 0:
		start_button.pressed.emit()
	elif posicao_vertical == 1:
		if posicao_horizontal == 0:
			credits_button.pressed.emit()
		else:
			exit_button.pressed.emit()

func _on_start_button_pressed() -> void:
	LoadManager.load_scene("res://ui//history.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_credits_button_pressed() -> void:
	LoadManager.load_scene("res://ui//credits_screen.tscn")
