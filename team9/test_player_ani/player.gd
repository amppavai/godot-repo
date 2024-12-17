extends CharacterBody2D

@export var speed = 200.0
@export var jump_velocity = -500.0
@export var acceleration : float = 15.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration)
	else:
		#option 1: sliding stop (can makes less "slidy" by removing /2)
		velocity.x = move_toward(velocity.x, 0, acceleration/2)
		#option 2: stop in place immediately
		#velocity.x = move_toward(velocity.x, 0, speed)
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true
		

	move_and_slide()
