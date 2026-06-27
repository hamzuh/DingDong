class_name Level extends StaticBody2D

signal exit(room, door, body)

@export var room_name: String
@export var theme: AudioStream

# Door name, spawn point
@export var door_dict: Dictionary[String, Vector2]

@export_group("Camera")
@export var limit_enabled: bool
@export var limit_left: int
@export var limit_top: int
@export var limit_right: int
@export var limit_bottom: int

func _ready() -> void:
	y_sort_enabled = true
