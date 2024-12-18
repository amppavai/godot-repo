extends CharacterBody2D

class_name Player

@export var jump_velocity = -300.0

const speed = 100
var current_dir = "none"
var usegun = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Define a dictionary to track key states
var key_states = {}

func _physics_process(delta):
	#update_key_state(KEY_E)
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	
	if is_key_just_pressed(KEY_E):
		if usegun == false:
			usegun = true
		else:
			usegun = false
		
		
	
	player_movement(delta)
		
	move_and_slide()
	

func player_movement(_delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		if usegun == false:
			play_anim(1)
		else:
			play_anim(2)
		
		velocity.x = speed

	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		if usegun == false:
			play_anim(1)
		else:
			play_anim(2)
		velocity.x = -speed

	
	#elif Input.is_action_pressed("ui_up"):
	#	current_dir = "up"
	#	velocity.x = 0
	#	velocity.y = -speed
	else:
		if is_on_floor():
			current_dir = "idle"	
			if usegun == false:
				play_anim(1)
			else:
				play_anim(2)
			
			velocity.x = 0

	move_and_slide()
	
func play_anim (movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement  == 1:
			anim.play("walk")
		elif movement == 2:
			anim.play("walk_gun")
			
	elif dir == "left":
		anim.flip_h = true
		if movement  == 1:
			anim.play("walk")
		elif movement == 2:
			anim.play("walk_gun")	
	elif dir == "idle":
		if movement  == 1:
			anim.play("idle")
		elif movement == 2:
			anim.play("idle_gun")
			
		
		
func update_key_state(key):
	if key not in key_states:
		key_states[key] = Input.is_key_pressed(key)
	else:
		key_states[key] = Input.is_key_pressed(key)

# Function to track if a key was just pressed
func is_key_just_pressed(key):
	# Get the current state of the key
	var is_pressed_now = Input.is_key_pressed(key)
	# Get the last state of the key (default to false if not tracked yet)
	var was_pressed_before = key_states.get(key, false)
	# Update the state in the dictionary
	key_states[key] = is_pressed_now
	# Return true only if the key is now pressed but wasn't before
	return is_pressed_now and not was_pressed_before
