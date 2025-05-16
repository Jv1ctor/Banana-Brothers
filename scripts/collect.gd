extends Area2D

@onready var collect_audio: AudioStreamPlayer = $CollectAudio

@export_enum("ballon", "cake", "chocolate") var item_name: String = "ballon" 		

func _on_body_entered(body: Node2D) -> void:
	var item: String = "points_%s" %item_name
	Globals[item] = 1
	Globals.points_good_deeds += 1
	
	collect_audio.play()
	await get_tree().create_timer(0.3).timeout  # para após 0.3 segundos
	collect_audio.stop()
	
	queue_free()
