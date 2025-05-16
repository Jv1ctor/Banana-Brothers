extends CharacterBody2D

class_name Npc

@onready var warning_sign: Warning_sign
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var default_direction = 1
@export_enum("ballon", "cake", "chocolate", "good_deeds") var count_condition: String = "ballon"
@export_multiline var final_text = "Obrigado...;" 

var direction

func _ready() -> void:
	direction = default_direction
	for child in get_children():
		if child is Warning_sign:
			warning_sign = child

func _process(delta: float) -> void:
	animated_sprite_2d.scale.x = direction	

	
func _on_zone_body_entered(body: Node2D) -> void:
	var direction_vector = sign(global_position - body.position)
	direction = direction_vector.x
	

	var item: String = "points_%s" %count_condition
	
	if(count_condition != "good_deeds"):
		if(Globals[item] > 0): 
			Globals[item] = 0
			warning_sign.set_text(final_text)
	else:
		if(Globals.final): 
			warning_sign.set_text(final_text)

		
		


func _on_zone_body_exited(body: Node2D) -> void:
	direction = default_direction 
