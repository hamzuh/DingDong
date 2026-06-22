extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

@export var speed = 80

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# Flip sidewalk
	#if direction.x < 0:
		#$"../../Sprite2D".flip_h = false
	#elif direction.x > 0:
		#$"../../Sprite2D".flip_h = true
	
	for dr in range(2):
		if direction[dr] > 0.5:
			direction[dr] = 1
		elif direction[dr] < -0.5:
			direction[dr] = -1
		else:
			direction[dr] = 0

	# Hmm
	#direction.y *= 0.8
	
	velocity = direction * speed
	
	# Animation stuff
	
	if direction:
		animation.play("walk_down")
	else:
		animation.play("idle")
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
