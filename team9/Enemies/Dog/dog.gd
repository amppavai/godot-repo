extends CharacterBody2D

const SPEED = 300.0

var isAttacking = false
@export var playerPos: Vector2

func _physics_process(delta: float) -> void:
	var dist = playerPos.distance_to(global_position)
	if dist < 500 and dist > 10:
		velocity = position.direction_to(playerPos) * SPEED
	elif dist > 10:
		$AnimatedSprite2D.play("Attack")
		isAttacking = true
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var player = collision.get_collider()
		"""if player is Player and not player.isInvincible:
			player.isInvincible = true
			player.health -= 10
			player.showDamage(1, 10)"""
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Attack":
		isAttacking = false
