extends Sprite2D

@onready var dialogue: Array[DE] = [load("res://Scripts/Dialogue/Items/Jeans/jeans.tres")]

func dialogue_start():
	Globals.dialogue.play(dialogue)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = true
		body.target = self

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = false
		body.target = null
