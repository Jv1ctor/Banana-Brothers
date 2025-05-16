extends Control
@onready var point_ballon: Label = $MarginContainer/VBoxContainer/HBoxContainer/pointBallon
@onready var point_cake: Label = $MarginContainer/VBoxContainer/HBoxContainer2/pointCake
@onready var point_chocolate: Label = $MarginContainer/VBoxContainer/HBoxContainer3/pointChocolate


func _handle_takeItem():
	if int(point_ballon.text) == 0:
		(point_ballon.get_parent() as HBoxContainer).hide()
	else:
		(point_ballon.get_parent() as HBoxContainer).show()
		
	if int(point_cake.text) == 0:
		(point_cake.get_parent() as HBoxContainer).hide()
	else:
		(point_cake.get_parent() as HBoxContainer).show()
		

	if int(point_chocolate.text) == 0:
		(point_chocolate.get_parent() as HBoxContainer).hide()
	else:
		(point_chocolate.get_parent() as HBoxContainer).show()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_handle_takeItem()
	
	point_ballon.text = str("%01d" % Globals.points_ballon)
	point_cake.text = str("%01d" % Globals.points_cake)
	point_chocolate.text = str("%01d" % Globals.points_chocolate)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	point_ballon.text = str("%01d" % Globals.points_ballon)
	point_cake.text = str("%01d" % Globals.points_cake)
	point_chocolate.text = str("%01d" % Globals.points_chocolate)
	
	
	_handle_takeItem()
		
