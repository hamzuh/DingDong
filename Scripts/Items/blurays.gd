extends StaticBody2D

@onready var dialogueArray: Array[DE] = [load("res://Scripts/Dialogue/Items/Blurays/blurays.tres"), load("res://Scripts/Dialogue/Items/Blurays/blurays2.tres"), load("res://Scripts/Dialogue/Items/Blurays/blurays3.tres")]

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
