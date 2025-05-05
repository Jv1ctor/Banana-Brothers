extends AnimatedSprite2D

class_name SwicthAnimation 
enum State { idle, run, stopping, jump, fall }


func trigger_animation(velocity: Vector2, direction: int, state: State):
	
	if scale.x == 1 && sign(velocity.x) == -1:
		scale.x = -1
	elif scale.x == -1 && sign(velocity.x) == 1:
		scale.x = 1
		
	if not get_parent().is_on_floor():
		play("jump")
	elif velocity.x != 0 and not state == State.jump:
		play("run")
	else:
		play("idle")
			
