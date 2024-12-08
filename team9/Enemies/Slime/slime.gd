extends CharacterBody2D

const SPEED = 300.0

@export var A: Node2D
@export var B: Node2D
@export var flip = true
var toB = true

func move():
	if toB:
		velocity.x -= SPEED
		if abs(position.x - B.position.x) <= 10:
			velocity.x = 0
			$AnimatedSprite2D.flip_h = flip
			toB = false
	else:
		velocity.x += SPEED
		if abs(position.x - A.position.x) <= 10:
			velocity.x = 0
			$AnimatedSprite2D.flip_h = not flip
			toB = true

func _physics_process(delta: float) -> void:
	move()
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var player = collision.get_collider()
		"""if player is Player and not player.isInvincible:
			player.isInvincible = true
			player.health -= 10
			player.showDamage(1, 10)"""
