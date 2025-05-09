extends Area2D

class_name ButtonPlatform

@onready var animated_sprite = $AnimatedSprite2D
var is_inside = false

@onready var colorBtn = (get_parent() as PuzzleMovePlatform).colorTheme if (get_parent() as PuzzleMovePlatform).colorTheme else "blue"


func _ready():
	
	animated_sprite.play("unpressed_{color}".format({"color": colorBtn }))
	#print("O script está rodando")

func _on_body_entered(body):
	if is_instance_of(body, Player):
		is_inside = true
		#print("Player1 entrou na área!")
		animated_sprite.play("pressed_{color}".format({ "color": colorBtn }))

func _on_body_exited(body):
	if is_instance_of(body, Player):
		is_inside = false
		#print("Player1 saiu da área!")
		animated_sprite.play("unpressed_{color}".format({ "color": colorBtn }))

func _process(delta):
	if is_inside:
		#print("O Player1 está dentro da área.")
		animated_sprite.play("pressed_{color}".format({ "color": colorBtn }))
