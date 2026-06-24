extends Node

@onready var musicPlayer = $"../AudioStreamPlayer"
@onready var current_level = $Intro
@onready var camera = $"../Mitku/Camera2D"

var links: Dictionary[Array, Array] = {
	["Intro", "exit"]: ["Hallway", "TopDoor"],
	["Hallway", "TopDoor"]: ["Intro", "exit"],
	["Hallway", "BottomDoor"]: ["My Room", "TopDoor"],
	["My Room", "TopDoor"]: ["Hallway", "BottomDoor"]
}

var room_name_scene_dict: Dictionary[String, String] = {
	"Intro": "res://Scenes/Environments/intro.tscn",
	"Hallway": "res://Scenes/Environments/hallway.tscn",
	"My Room": "res://Scenes/Environments/my_room.tscn"
}

func _ready() -> void:
	current_level.exit.connect(_on_room_exit)
	
func _on_room_exit(room_name, door, body):
	body.set_can_move(false)
	musicPlayer.stop()
	
	var new_place = links[[room_name, door]]
	var new_scene = room_name_scene_dict[new_place[0]]
	
	current_level.queue_free()
	current_level = load(new_scene).instantiate()
	current_level.exit.connect(_on_room_exit)
	add_child(current_level)
	
	body.position = current_level.door_dict[new_place[1]]
	body.set_can_move(true)
	
	musicPlayer.stream = current_level.theme
	musicPlayer.play()
	
	camera.limit_enabled = current_level.limit_enabled
	camera.limit_left = current_level.limit_left
	camera.limit_top = current_level.limit_top
	camera.limit_right = current_level.limit_right
	camera.limit_bottom = current_level.limit_bottom
