extends Node2D

const WAIT_DURATION = 1

@onready var platform = $platform

@export var move_speed = 3
@export var distance = 192
@export var moving_horizontal = true

var start_position: Vector2
var end_position: Vector2
var going_forward = true
var is_on = false
var wait_timer = 0.0

func setOn() -> void:
	is_on = true 

func setOff() -> void:
	is_on = false

func _ready() -> void:
	start_position = platform.position
	var direction = Vector2.RIGHT if moving_horizontal else Vector2.UP
	end_position = start_position + direction * distance

func _physics_process(delta: float) -> void:
	if not is_on:
		return

	if wait_timer > 0:
		wait_timer -= delta
		return

	var target = end_position if going_forward else start_position
	platform.position = platform.position.move_toward(target, move_speed)

	if platform.position == target:
		going_forward = !going_forward
		wait_timer = WAIT_DURATION
