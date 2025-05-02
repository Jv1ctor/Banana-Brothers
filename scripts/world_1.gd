extends Node

@onready var camera := $Camera as Camera2D
@onready var moving_platform: Node2D = $moving_platform
@onready var puzzle: Area2D = $Puzzle

func _ready():
	camera.add_player($Player)
	camera.add_player($Player2)
	
	
func _process(delta: float) -> void:
	if puzzle.is_inside:
		print(moving_platform.is_on)
		moving_platform.setOn()
	else:
		moving_platform.setOff()
	
