extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

@export var speed = 80

var direction: Vector2
var last_direct = "down"
var last_direct_vector: Vector2

func get_input():
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Parse as flat unnormalised 8-way movement
	for dr in range(2):
		if direction[dr] > 0.5:
			direction[dr] = 1
		elif direction[dr] < -0.5:
			direction[dr] = -1
		else:
			direction[dr] = 0
	
	if direction:
		last_direct_vector = direction
	
	# Scale the diagonal speed down a bit
	# Not fully normalised because that's boring
	if direction.x and direction.y:
		direction = direction.limit_length(1.2)
	
	velocity = direction * speed
	
	# Animation stuff
	
	#if direction:
		#if direction.dot(last_direct_vector) <= 0:
			
	
	# Flip sidewalk
	if direction.x < 0:
		animation.play("walk_side")
		animation.flip_h = true
		# This is unbelievably bad
		last_direct = "left"
	elif direction.x > 0:
		animation.play("walk_side")
		animation.flip_h = false
		last_direct = "right"
	
	if not direction.x:
		if direction.y > 0:
			animation.flip_h = false
			animation.play("walk_down")
			last_direct = "down"
		elif direction.y < 0:
			animation.flip_h = false
			animation.play("walk_up")
			last_direct = "up"
		
	if not direction:
		match last_direct:
			"left":
				animation.play("idle_side")
				animation.flip_h = true
			"right":
				animation.play("idle_side")
				animation.flip_h = false
			"down":
				animation.play("idle_down")
				animation.flip_h = false
			"up":
				animation.play("idle_up")
				animation.flip_h = false
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
