extends CharacterBody2D

class_name Player
@onready var audio_jump: AudioStreamPlayer2D = $AudioJump

@export var controls: PlayerControls = null
@export var texture: SpriteFrames = null
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D as SwicthAnimation
enum State { idle, run, stopping, jump, fall }

var _current_state = State.idle

func _ready() -> void:
	animated_sprite_2d.sprite_frames = texture

func _set_state(newState: State):
	#var before_state = _current_state
	if newState == _current_state:
		return
	_current_state = newState


func handle_player_move(delta):
	var direction := Input.get_axis(controls.move_left, controls.move_right)
		
	match _current_state:
		State.idle:
			if direction != 0:
				_set_state(State.run)
			else:
				_set_state(State.stopping)
			
			if Input.is_action_just_pressed(controls.jump) and is_on_floor():
				audio_jump.play()
				_set_state(State.jump)
			#elif not is_on_floor():
				#_set_state(State.fall)
		State.run:
			velocity.x = direction * SPEED
			
			if Input.is_action_just_pressed(controls.jump) and is_on_floor():
				audio_jump.play()
				_set_state(State.jump)
			#elif not is_on_floor():
				#_set_state(State.fall)
		State.jump:				
			velocity.y = JUMP_VELOCITY
			
			if not is_on_floor():
				_set_state(State.fall)
						
		State.stopping:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
			if velocity.x == 0:
				_set_state(State.idle)
		
		State.fall:
			_set_state(State.idle)
			#velocity += get_gravity() * delta
			#if is_on_floor():
				#_set_state(State.idle)
			
	#print(_current_state)
	animated_sprite_2d.trigger_animation(velocity, direction, _current_state)
			

func _physics_process(delta: float) -> void:	
	## Gavidade aplicada
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	handle_player_move(delta)
	
	move_and_slide()
