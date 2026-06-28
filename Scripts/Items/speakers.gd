extends StaticBody2D

@onready var inspectDialogue: Array[DE] = [load("res://Scripts/Dialogue/Items/Speakers/speaker1.tres")]
@onready var onDialogue: Array[DE] = [load("res://Scripts/Dialogue/Items/Speakers/speaker2.tres")]
@onready var sprite = $AnimatedSprite2D

@onready var musicArray: Array[AudioStream] = [load("res://Audio/Music/wyldloopguitars.wav"), load("res://Audio/Music/iloveyall(c64).wav"), load("res://Audio/Music/cdripperarrange.wav")]
var musicIndex: int = 0

func _ready() -> void:
	if Globals.room_music:
		sprite.play("playing")
		Globals.music.play()
	else:
		sprite.play("idle")
		Globals.music.stop()

func dialogue_start():
	if Globals.room_music:
		sprite.play("idle")
		Globals.music.stop()
		Globals.dialogue.play(inspectDialogue)
	else:
		sprite.play("playing")
		Globals.music.stream = musicArray[musicIndex]
		musicIndex += 1
		if musicIndex >= musicArray.size():
			musicIndex = 0
		Globals.music.play()
		Globals.dialogue.play(onDialogue)
	Globals.room_music = not Globals.room_music

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = true
		body.target = self

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.talk = false
		body.target = null
