class_name DialogueText extends Resource

@export var portrait: Texture
@export_multiline var text: String
@export_range(0.1, 2, 0.1) var textSpeed: float = 1

@export var voiceSound: AudioStream
