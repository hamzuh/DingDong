extends Level

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		exit.emit(room_name, "exit", body)
