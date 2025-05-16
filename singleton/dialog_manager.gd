extends Node

@onready var dialog_box_scene = preload("res://prefebs/dialog_box.tscn")

var message_lines: Array[String] = []
var current_line = 1

var dialog_box 
var dialog_box_position := Vector2.ZERO

var is_message_active := false
var can_advance_message := false

var current_npc_id: String = ""
var max_points = 3

func start_message(position: Vector2, lines: Array[String], npc_id: String = ""):
	if is_message_active:
		return
	
	current_npc_id = npc_id
	message_lines = lines
	dialog_box_position = position
	show_text()
	is_message_active = true

	
func show_text():
	dialog_box = dialog_box_scene.instantiate()
	dialog_box.text_display_finished.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = dialog_box_position
	dialog_box.display_text(message_lines[current_line])
	#can_advance_message = true
	
func _on_all_text_displayed():
	can_advance_message = true
	#print("finalizou o texto")
	
func _unhandled_input(event: InputEvent) -> void:
	if is_message_active and can_advance_message and dialog_box != null \
		and (event.is_action_pressed("p1_ui_action") or event.is_action_pressed("p2_ui_action")):
		
		dialog_box.queue_free()
		current_line += 1 
		can_advance_message = false
		if current_line >= message_lines.size():
			is_message_active = false
			current_line = 1
		
			if current_npc_id == "mamae_nana" and Globals.final:
				get_tree().change_scene_to_file("res://ui/final_screen.tscn")	
			
			return
			
		
			
		show_text()
