extends AnimatableBody2D

@onready var anim := $anim as AnimationPlayer
@onready var respawn_timer := $respawn_timer as Timer
@onready var respawn_position := global_position

@export var reset_timer := 3.0

var velocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_trigged := false

func _ready() -> void:
	anim.play()
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta

func has_collided_with(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !is_trigged:
		is_trigged = true
		anim.play("shake")
		velocity = Vector2.ZERO


func _on_anim_animation_finished(anim_name: StringName) -> void:
	set_physics_process(true)
	respawn_timer.start(reset_timer)


func _on_respawn_timer_timeout() -> void:
	set_physics_process(false)
	global_position = respawn_position
	is_trigged = false
