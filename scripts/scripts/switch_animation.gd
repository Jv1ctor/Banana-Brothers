extends AnimatedSprite2D

class_name SwicthAnimation 

func trigger_animation(velocity: Vector2, direction: int):
	
	if not get_parent().is_on_floor():
		play("jump")
	

	if scale.x == 1 && sign(velocity.x) == -1:
		scale.x = -1
	elif scale.x == -1 && sign(velocity.x) == 1:
		scale.x = 1
			
	if velocity.x != 0:
		play("run")
	else:
		play("idle")
			
