extends Node

func _ready() -> void:
	Input.mouse_mode = 2

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
