extends Control

@onready var textbox = $HBoxContainer/Text
@onready var portrait = $HBoxContainer/Portrait
@onready var sfx = $Voice
@onready var timer = $Timer

var dialogueArray: Array
var current_item: int = 0

var textlength: int = 0
var vis_char: int = 0
var finished_texture: Texture

var soundArray: Array[AudioStream]

func _ready() -> void:
	self.visible = false

func play(textArray):
	dialogueArray = textArray
	var textRes = textArray[current_item]
	
	self.visible = true
	textbox.text = textRes.text
	textbox.visible_ratio = 0
	textlength = textRes.text.length()
	vis_char = 0
	
	timer.wait_time = (0.05 * textRes.textSpeed) * textlength
	timer.start()
	
	soundArray = textRes.voiceSound
	
	if textRes.portrait:
		portrait.visible = true
		portrait.texture = textRes.portrait
		finished_texture = textRes.portrait
		if textRes.animatedPortrait:
			portrait.texture = textRes.animatedPortrait
			finished_texture = textRes.portrait
	else:
		portrait.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and self.visible:
		if textbox.visible_ratio == 1:
			if current_item >= dialogueArray.size() - 1:
				self.visible = false
				current_item = 0
				# This is really bad
				await get_tree().process_frame
				Globals.player.set_can_move(true)
				Globals.player.speaking = false
			else:
				current_item += 1
				play(dialogueArray)
				
		else:
			timer.stop()
			textbox.visible_ratio = 1

func _physics_process(delta: float) -> void:
	if self.visible:
		textbox.visible_ratio = 1 - (timer.time_left / timer.wait_time)
		if vis_char < textbox.visible_characters:
			sfx.volume_db = 0 - randf_range(0, 1)
			sfx.stream = soundArray.pick_random()
			sfx.play()
			vis_char = textbox.visible_characters
		if textbox.visible_ratio == 1:
			portrait.texture = finished_texture
