extends CharacterBody2D

@export var controls: PlayerControls = null
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D as SwicthAnimation
enum State { idle, run, stopping, jump, fall }

var _current_state = State.idle

func _set_state(newState: State):
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
				_set_state(State.jump)
			#elif not is_on_floor():
				#_set_state(State.fall)
		State.run:
			velocity.x = direction * SPEED
			
			if Input.is_action_just_pressed(controls.jump) and is_on_floor():
				_set_state(State.jump)
			#elif not is_on_floor():
				#_set_state(State.fall)
		State.jump:				
			velocity.y = JUMP_VELOCITY
			_set_state(State.fall)
						
		State.stopping:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			_set_state(State.idle)
		
		State.fall:
			_set_state(State.idle)
			#velocity += get_gravity() * delta
			#if is_on_floor():
				#_set_state(State.idle)
			
			
	animated_sprite_2d.trigger_animation(velocity, direction)
			

func _physics_process(delta: float) -> void:	
	## Gavidade aplicada
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	handle_player_move(delta)
	
	move_and_slide()
