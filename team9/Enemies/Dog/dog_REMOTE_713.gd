# Xavier
extends CharacterBody2D

@export var speed = 150
var target
var hasTarget = false
@export var hp = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isAttacking = false
@onready var timer = $Timer
var cd = false
@onready var player = $"../MainPlayer(Polina)"

func _physics_process(delta: float) -> void:
	if hasTarget:
		target = player.position
		if position.distance_to(target) > 31 and not isAttacking:
			$AnimatedSprite2D.play("Run")
			velocity = position.direction_to(target) * speed
			if target.x > position.x:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		elif not isAttacking and not cd:
			$AnimatedSprite2D.play("Attack")
			isAttacking = true
		elif isAttacking:
			velocity.x = 0
			for i in get_slide_collision_count():
				var collision = get_slide_collision(i)
				var player = collision.get_collider()
				
				if player is Player:
					$Bite.play()
					#player.health -= 10
	else:
		$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	if hp <= 0:
		$AnimatedSprite2D.play("Death")
	
	velocity.y += gravity
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Attack":
		print("end attack")
		isAttacking = false
		cd = true
		$Timer.start(1)
		$AnimatedSprite2D.play("Idle")
	elif $AnimatedSprite2D.animation == "Death":
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		modulate = Color.DARK_RED
		isAttacking = false
		hasTarget = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		hasTarget = false
		modulate = Color.WHITE

func _on_timer_timeout() -> void:
	cd = false
