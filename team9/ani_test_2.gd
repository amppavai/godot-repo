extends CharacterBody2D

@export var jump_velocity = -400.0 #added by Ani
@export var speed = 100.0 #changed by Ani
@export var acceleration : float = 15.0

var current_dir = "none"

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
	
	player_movement(delta)
		
	move_and_slide()
	

func player_movement(_delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
	else:
		if is_on_floor():
			current_dir = "idle"
			play_anim(1)
			velocity.x = 0

	move_and_slide()
	
func play_anim (movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement  == 1:
			anim.play("walk")
	elif dir == "left":
		anim.flip_h = true
		if movement  == 1:
			anim.play("walk")
	elif dir == "idle":
		if movement  == 1:
			anim.play("idle")
		
		
