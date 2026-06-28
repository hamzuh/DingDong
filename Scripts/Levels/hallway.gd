extends Level

@onready var starwalker = $Starwalker

func _ready() -> void:
	if Globals.visible_starwalker:
		starwalker.visible = true
		starwalker.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		starwalker.visible = false
		starwalker.process_mode = Node.PROCESS_MODE_DISABLED
		
func _on_top_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		exit.emit(room_name, "TopDoor", body)

func _on_bottom_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		exit.emit(room_name, "BottomDoor", body)
