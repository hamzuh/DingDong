extends CanvasModulate

@onready var animation = $AnimationPlayer
var callernode

func fade_in(caller):
	callernode = caller
	animation.play("fade_in")

func fade_out():
	animation.play("fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		callernode.proceed()
