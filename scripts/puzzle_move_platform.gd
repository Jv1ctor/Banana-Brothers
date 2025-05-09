extends Node2D

class_name PuzzleMovePlatform

@export var button1Platform: ButtonPlatform = null
@export var button2Platform: ButtonPlatform = null
@export var platform: Platform = null


@export_enum("red", "blue", "green", "yellow") var colorTheme: String = "blue" 		

func _process(delta: float) -> void:
	if button1Platform and button2Platform:
		if button1Platform.is_inside or button2Platform.is_inside:
			platform.setOn()
		else:
			platform.setOff()

		
