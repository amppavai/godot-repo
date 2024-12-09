extends CharacterBody2D

@export var speed = 150
@export var range = 200
@export var hp = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isAttacking = false
@onready var player = $"../Player ( Polina)"

func _physics_process(delta: float) -> void:
	var dist = player.position.distance_to(position)
	if dist < range and dist > 50:
		$AnimatedSprite2D.play("Idle")
		velocity = position.direction_to(player.position) * speed
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	if dist <= 50:
		$AnimatedSprite2D.play("Attack")
		isAttacking = true
	
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var player = collision.get_collider()
			"""if player is Player:
				player.isInvincible = true
				player.health -= 10
				player.showDamage(1, 10)"""
	
	if hp <= 0:
		$AnimatedSprite2D.play("Death")
	
	velocity.y += gravity
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Attack":
		isAttacking = false
		#await get_tree().create_timer(1.0).timeout
	elif $AnimatedSprite2D.animation == "Death":
		queue_free()
