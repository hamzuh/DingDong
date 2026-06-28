class_name DialogueInspect extends DE

var portrait: Texture = null
var animatedPortrait: AnimatedTexture = null
@export_multiline var text: String
@export_range(0.1, 4, 0.1) var textSpeed: float = 1

var voiceSound: Array[AudioStream] = [load("res://Audio/UI/Dialogue/snd_txtal.wav")]
