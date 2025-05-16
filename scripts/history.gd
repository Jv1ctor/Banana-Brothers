extends Node2D

@onready var texture_rect = $TextureRect
@onready var fade = $ColorRect
@onready var anim = $AnimationPlayer

var imagens = [
	preload("res://ui/history/intro1.png"),
	preload("res://ui/history/intro2.png"),
	preload("res://ui/history/intro3.png"),
]

var index = 0
var iniciou = false

func transition_in(time: float):
	await get_tree().create_timer(time).timeout
	anim.play("fade_in")

func transition_out(time: float):
	await get_tree().create_timer(time).timeout
	anim.play("fade_out")

func _ready() -> void:
	for image in imagens:
		await transition_out(3)
		index += 1
		texture_rect.texture = image
		await transition_in(10)
		
		if index >= imagens.size():
			await transition_out(3)
			get_tree().change_scene_to_file("res://levels/world_1.tscn")
			return
			
