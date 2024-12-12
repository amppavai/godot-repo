extends CharacterBody2D

@export var speed = 300
@onready var hasTarget = false
@export var hp = 100
var target
var goingUp = false
@export var player: Node2D
@onready var yPos = position.y
@onready var upPos = position

func _physics_process(delta: float) -> void:
	if hasTarget && not goingUp:
		velocity = position.direction_to(target) * speed
		if position.distance_to(target) <= 10:
			goingUp = true
			target = player.position
			var xPos
			if position.x > target.x:
				xPos = position.x - target.x
			else:
				xPos = target.x + (target.x - position.x)
			upPos = Vector2(xPos, yPos)
	elif hasTarget && goingUp:
		if position.distance_to(upPos) <= 10:
			goingUp = false
			target = player.position
			var xPos
			if position.x > target.x:
				xPos = position.x - target.x
			else:
				xPos = target.x + (target.x - position.x)
			upPos = Vector2(xPos, yPos)
		velocity = position.direction_to(upPos) * speed
	if hp <= 0:
		$AnimatedSprite2D.play("Death")
	
	if hasTarget:
		if position.x > target.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		if position.distance_to(upPos) > 10:
			velocity = position.direction_to(upPos) * speed
		else:
			velocity = Vector2(0, 0)
			
	for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var player = collision.get_collider()
			
			"""if player is Player:
				player.health -= 10"""
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		hasTarget = true
		goingUp = false
		target = body.position

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		hasTarget = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Death":
		queue_free()
