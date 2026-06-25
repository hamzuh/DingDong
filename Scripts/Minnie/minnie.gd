extends StaticBody2D

@onready var introSpeech = load("res://Scripts/Dialogue/Minnie/Intro.tres")
# Make an NPC class and do all this stuff in there

func dialogue_start():
	Globals.dialogue.play(introSpeech)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = true
		body.target = self

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = false
		body.target = null
