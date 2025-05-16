extends Node2D

class_name Warning_sign

@onready var texture: Sprite2D = $texture
@onready var area_sign: Area2D = $Area_sign

@export_multiline var text = ""
@export var spacing = 0
@export var npc_id: String = ""

var lines: Array[String] = []
var _is_player_in_area = false


func set_text(new_text: String) -> void:
	text = new_text
	lines = _wrap_text(text, spacing)


func _ready():
	lines = _wrap_text(text, spacing)
	
	
func _speech_separation(text:String):
	return text.split(";")

func _wrap_text(text: String, max_length: int) -> Array[String]:
	var speeches = _speech_separation(text)
	var lines: Array[String] = [""]
	
	for speeche in speeches:
		var words = speeche.split(" ")
		var current_line = ""

		for word in words:
			if current_line.length() == 0:
				current_line = word
			elif (current_line.length() + word.length() + 1) <= max_length:
				current_line += " " + word
				lines.pop_back()
			else:
				current_line = word

			if current_line.length() > 0:
				lines.append(current_line)
	return lines


func _is_player_inside() -> bool:
	for body in area_sign.get_overlapping_bodies():
		if body.name == "Player" or body.name == "Player2": # ou use grupo se preferir
			return true
	return false

func _unhandled_input(event: InputEvent) -> void:
	if _is_player_inside():
		texture.show()
		
		if (event.is_action_pressed("p1_ui_action") or event.is_action_pressed("p2_ui_action")) \
			and !DialogManager.is_message_active:
			
			print(lines)
			texture.hide()
			DialogManager.start_message(global_position + Vector2(0, -50), lines, npc_id)
	else:
		texture.hide()
		
		# só encerra se o dialogo ativo for nosso
		if DialogManager.dialog_box != null \
			and DialogManager.dialog_box.global_position == global_position + Vector2(0, -50):
			
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
