extends StaticBody2D

@onready var introSpeech: Array[DialogueText] = [load("res://Scripts/Dialogue/Minnie/Intro/Intro.tres"), load("res://Scripts/Dialogue/Minnie/Intro/Intro2.tres"), load("res://Scripts/Dialogue/Minnie/Intro/Intro3.tres")]
@onready var danceSpeech: Array[DialogueText] = [load("res://Scripts/Dialogue/Minnie/Nice Dance Moves/NiceDance.tres"), load("res://Scripts/Dialogue/Minnie/Nice Dance Moves/Seriously.tres")]
@onready var thanksSpeech: Array[DE] = [load("res://Scripts/Dialogue/Minnie/Thanks/Thanks.tres"), load("res://Scripts/Dialogue/Minnie/Thanks/Thanks2.tres")]
@onready var whySpeech: Array[DE] = [load("res://Scripts/Dialogue/Minnie/Why/Why.tres")]

var flickspeech: bool = true
# Make an NPC class and do all this stuff in there

func dialogue_start():
	if Globals.room_music:
		if Globals.music_helped:
			Globals.dialogue.play(whySpeech)
		else:
			if flickspeech:
				Globals.dialogue.play(introSpeech)
			else:
				Globals.visible_starwalker = true
				Globals.dialogue.play(danceSpeech)
			flickspeech = not flickspeech
	else:
		Globals.music_helped = true
		Globals.dialogue.play(thanksSpeech)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = true
		body.target = self

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = false
		body.target = null
