extends Node

@onready var camera := $Camera as Camera2D

func _ready():
	camera.add_player($Player)
	camera.add_player($Player2)
