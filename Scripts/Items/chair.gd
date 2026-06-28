extends StaticBody2D

@onready var dialogueArray: Array[DE] = [load("res://Scripts/Dialogue/Items/Chair/chair.tres")]

func dialogue_start():
	Globals.dialogue.play(dialogueArray)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = true
		body.target = self

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = false
		body.target = null
