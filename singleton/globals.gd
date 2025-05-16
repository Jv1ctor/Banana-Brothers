extends Node


var level = "world_1"
var points_ballon = 0
var points_cake = 0
var points_chocolate = 0


var points_good_deeds = 0

var max_points = 3

var final = false
func _process(delta: float) -> void:
	if(points_good_deeds >= max_points):
		final = true
	

func reset():
	final = false
	points_good_deeds = 0
	points_ballon = 0
	points_cake = 0
	points_chocolate = 0
