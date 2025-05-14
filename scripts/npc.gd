extends CharacterBody2D

class_name Npc

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var default_direction = 1

var direction

func _ready() -> void:
	direction = default_direction

func _process(delta: float) -> void:
	animated_sprite_2d.scale.x = direction
	
func _on_zone_body_entered(body: Node2D) -> void:
	var direction_vector = sign(global_position - body.position)
	direction = direction_vector.x


func _on_zone_body_exited(body: Node2D) -> void:
	direction = default_direction 
