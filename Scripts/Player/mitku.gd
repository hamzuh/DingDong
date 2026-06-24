extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

@export var speed = 80

var can_move: bool = true
var direction: Vector2
var unscaled_direction: Vector2
var last_direct = "down"
var locked: bool = false

func get_input():
	if can_move:
		direction = Input.get_vector("left", "right", "up", "down")
	else:
		direction = Vector2(0, 0)
	
	# Parse as flat unnormalised 8-way movement
	for dr in range(2):
		if direction[dr] > 0.5:
			direction[dr] = 1
		elif direction[dr] < -0.5:
			direction[dr] = -1
		else:
			direction[dr] = 0
	
	unscaled_direction = direction
	
	# Scale the diagonal speed down a bit
	# Not fully normalised because that's boring
	direction = direction.limit_length(1.2)
	
	velocity = direction * speed
	
func animate():
	if unscaled_direction:
		if abs(unscaled_direction.x) != abs(unscaled_direction.y):
			locked = true
			
			if direction.x < 0:
				animation.play("walk_side")
				animation.flip_h = true
				# This is unbelievably bad
				last_direct = "left"
			elif direction.x > 0:
				animation.play("walk_side")
				animation.flip_h = false
				last_direct = "right"
				
			if direction.y > 0:
				animation.flip_h = false
				animation.play("walk_down")
				last_direct = "down"
			elif direction.y < 0:
				animation.flip_h = false
				animation.play("walk_up")
				last_direct = "up"
				
		elif not locked:
			locked = true
			
			if direction.x < 0:
				animation.play("walk_side")
				animation.flip_h = true
				last_direct = "left"
			elif direction.x > 0:
				animation.play("walk_side")
				animation.flip_h = false
				last_direct = "right"
				
			if direction.y > 0:
				animation.flip_h = false
				animation.play("walk_down")
				last_direct = "down"
			elif direction.y < 0:
				animation.flip_h = false
				animation.play("walk_up")
				last_direct = "up"
				
	# Commented version looks a little inconsistent	
	#if not unscaled_direction or self.get_real_velocity().length() < 0.1:
	else:
		locked = false
		
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
	
func set_can_move(enable: bool):
	can_move = enable

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	animate()
