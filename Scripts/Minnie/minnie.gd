extends StaticBody2D

@onready var introSpeech: Array[DialogueText] = [load("res://Scripts/Dialogue/Minnie/Intro/Intro.tres"), load("res://Scripts/Dialogue/Minnie/Intro/Intro2.tres"), load("res://Scripts/Dialogue/Minnie/Intro/Intro3.tres")]
@onready var danceSpeech: Array[DialogueText] = [load("res://Scripts/Dialogue/Minnie/Nice Dance Moves/NiceDance.tres"), load("res://Scripts/Dialogue/Minnie/Nice Dance Moves/Seriously.tres")]
var flickspeech: bool = true
# Make an NPC class and do all this stuff in there

func dialogue_start():
	if flickspeech:
		Globals.dialogue.play(introSpeech)
	else:
		Globals.dialogue.play(danceSpeech)
	flickspeech = not flickspeech

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = true
		body.target = self

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = false
		body.target = null
