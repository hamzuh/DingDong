extends Control

@onready var textbox = $HBoxContainer/Text
@onready var portrait = $HBoxContainer/Portrait
@onready var sfx = $Voice

func _ready() -> void:
	self.visible = false

func play(textRes):
	self.visible = true
	textbox.text = textRes.text
	portrait.texture = textRes.portrait

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and self.visible:
		self.visible = false
		# This is really bad
		await get_tree().process_frame
		Globals.player.set_can_move(true)
		Globals.player.speaking = false
		
