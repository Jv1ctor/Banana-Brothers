extends CharacterBody2D

@export var controls: PlayerControls = null
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D as SwicthAnimation

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and controls.player_index == 0:
		velocity += get_gravity() * delta
		
	if not is_on_floor() and controls.player_index == 1:
		velocity += get_gravity() * delta




	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if(controls.player_index == 0 ):
			# Handle jump.
		if Input.is_action_just_pressed(controls.jump) and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		var direction := Input.get_axis(controls.move_left, controls.move_right)
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		animated_sprite_2d.trigger_animation(velocity, direction)
		move_and_slide()
	elif controls.player_index == 1:
		# Handle jump.
		if Input.is_action_just_pressed(controls.jump) and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		var direction := Input.get_axis(controls.move_left, controls.move_right)
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		animated_sprite_2d.trigger_animation(velocity, direction)
		move_and_slide()
