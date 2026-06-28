extends Node

@onready var dialogue = get_node("../Base/CanvasLayer/Textbox")
@onready var player = get_node("../Base/Mitku")
@onready var music = get_node("../Base/AudioStreamPlayer")

var visible_starwalker = false
var room_music = true
var music_helped = false
