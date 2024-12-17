extends CharacterBody2D


@export var jump_velocity = -300.0

const speed = 100
var current_dir = "none"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	player_movement(delta)
		
	move_and_slide()
	

func player_movement(_delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		#velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		#velocity.y = 0
	#elif Input.is_action_pressed("ui_down"):
	#	current_dir = "down"
	#	velocity.x = 0
	#	velocity.y = speed
	#elif Input.is_action_pressed("ui_up"):
	#	current_dir = "up"
	#	velocity.x = 0
	#	velocity.y = -speed
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
		
		
