extends StaticBody2D

@onready var dialogue: Array[DialogueInspect] = [load("res://Scripts/Dialogue/Starwalker/pissingmeoff.tres"), load("res://Scripts/Dialogue/Starwalker/original.tres")]

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
