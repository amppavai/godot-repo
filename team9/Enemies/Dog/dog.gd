extends CharacterBody2D

@export var speed = 150
@onready var target = false
@export var hp = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isAttacking = false
@onready var player = $"../Player ( Polina)"
@onready var timer = $"../Timer"
var cd = false

func _physics_process(delta: float) -> void:
	var dist = player.position.distance_to(position)
	print(dist)
	if not cd and not isAttacking:
		if target == false:
			$AnimatedSprite2D.play("Idle")
		elif dist <= 31:
			if player.position.x > position.x:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("Attack")
			isAttacking = true
		else:
			$AnimatedSprite2D.play("Run")
			velocity = position.direction_to(player.position) * speed
			if player.position.x > position.x:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
	elif not cd:
		velocity.x = 0
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
		print("after attack " + str(scale.x))
		isAttacking = false
		cd = true
		$Timer.start(1)
		$AnimatedSprite2D.play("Idle")
	elif $AnimatedSprite2D.animation == "Death":
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		modulate = Color.DARK_RED
		target = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		target = false
		modulate = Color.WHITE

func _on_timer_timeout() -> void:
	cd = false
