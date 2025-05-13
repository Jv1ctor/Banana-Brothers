@tool
extends Node2D


class_name Platform

const WAIT_DURATION = 1

@onready var platform = $platform

@onready var atlas_texture = $platform/Sprite2D.texture as AtlasTexture

@export_range(1, 10) var move_speed = 3
@export var distance = 192:
	set(value):
		distance = value
		queue_redraw()

@export var moving_horizontal = true:
	set(value):
		moving_horizontal = value
		queue_redraw()

@export var invert_direction := false:
	set(value):
		invert_direction = value
		queue_redraw()


@onready var colorPlatform = "blue"

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
	atlas_texture = atlas_texture.duplicate()
	$platform/Sprite2D.texture = atlas_texture
	
	colorPlatform = (get_parent() as PuzzleMovePlatform).colorTheme if (get_parent() as PuzzleMovePlatform).colorTheme else "blue"
	
	atlas_texture.atlas = load("res://assets/sprites/platforms/{color}.png".format({"color": colorPlatform}))
	atlas_texture.region = Rect2(96, 64, 32, 16)
	start_position = platform.position
	var direction = Vector2.RIGHT if moving_horizontal else Vector2.UP

	if invert_direction:
		direction *= -1  # Inverte a direção
	
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
		
func _draw() -> void:
	if not Engine.is_editor_hint():
		return
	
	if not platform:
		return

	var from = platform.position
	var direction = Vector2.RIGHT if moving_horizontal else Vector2.UP
	
	if invert_direction:
		direction *= -1
		
	var to = from + direction * distance
	draw_line(from, to, Color.RED, 2, true)
