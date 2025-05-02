extends Node

@onready var camera := $Camera as Camera2D

@onready var moving_platform_1: Node2D = $"platforms1/moving_platform -1"
@onready var moving_platform_2: Node2D = $"platforms2/moving_platform -1"
@onready var moving_platform_3: Node2D = $"platforms3/moving_platform -1"
@onready var puzzle_1: Area2D = $"platforms1/Puzzle-1"
@onready var puzzle_2: Area2D = $"platforms2/Puzzle-1"
@onready var puzzle_3: Area2D = $"platforms3/Puzzle-1"
@onready var puzzle_return_1: Area2D = $"platforms1/Puzzle-2"
@onready var puzzle_return_2: Area2D = $"platforms2/Puzzle-2"
@onready var puzzle_return_3: Area2D = $"platforms3/Puzzle-2"

func _ready():
	camera.add_player($Player)
	camera.add_player($Player2)
	
	
func _process(delta: float) -> void:
	if puzzle_1.is_inside or puzzle_return_1.is_inside:
		moving_platform_1.setOn()
	else:
		moving_platform_1.setOff()
		
	if puzzle_2.is_inside or puzzle_return_2.is_inside:
		moving_platform_2.setOn()
	else:
		moving_platform_2.setOff()
		
	if puzzle_3.is_inside or puzzle_return_3.is_inside:
		moving_platform_3.setOn()
	else:
		moving_platform_3.setOff()
		
		
	
