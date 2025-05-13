extends CanvasLayer

signal loading_screen_has_full_coverage

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var progressBar : ProgressBar = $Panel/ProgressBar
@onready var bananaBrothers : Label = $Panel/BananaBrothers
@onready var carregando : Label = $Panel/Carregando

func _update_progress_bar(new_value: float) -> void:
	progressBar.set_value_no_signal(new_value * 100)
	pass

func _start_outro_animation() -> void:
	#await Signal(animationPlayer, "animation_finished")
	animationPlayer.play("end_load")
	#await Signal(animationPlayer, "animation_finished")
	self.queue_free()
