extends Area2D

@onready var balao: AudioStreamPlayer = $Balao

func _on_body_entered(body: Node2D) -> void:	
	queue_free()
