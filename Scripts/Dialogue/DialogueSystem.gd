extends Control

@onready var textbox = $HBoxContainer/Text
@onready var portrait = $HBoxContainer/Portrait
@onready var sfx = $Voice
@onready var timer = $Timer

var textlength: int = 0
var vis_char: int = 0

func _ready() -> void:
	self.visible = false

func play(textRes):
	self.visible = true
	textbox.text = textRes.text
	textbox.visible_ratio = 0
	textlength = textRes.text.length()
	vis_char = 0
	
	timer.wait_time = 0.05 * textlength
	timer.start()
	
	portrait.texture = textRes.portrait
	sfx.stream = textRes.voiceSound
	sfx.play()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and self.visible:
		self.visible = false
		# This is really bad
		await get_tree().process_frame
		Globals.player.set_can_move(true)
		Globals.player.speaking = false

func _physics_process(delta: float) -> void:
	if self.visible:
		textbox.visible_ratio = 1 - (timer.time_left / timer.wait_time)
		if vis_char < textbox.visible_characters:
			sfx.play()
			vis_char = textbox.visible_characters
