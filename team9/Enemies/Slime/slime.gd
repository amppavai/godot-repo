extends CharacterBody2D

const SPEED = 100

@onready var player = $"../Player ( Polina)"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var hp = 100
@export var A: Node2D
@export var flip = true
var toA = true
var isAttacking = false
@onready var pos = position

func move():
	if toA:
		velocity.x = -SPEED
		if position.distance_to(A.position) <= 10:
			velocity.x = 0
			$AnimatedSprite2D.flip_h = flip
			toA = false
	else:
		velocity.x = SPEED
		if position.distance_to(pos) <= 10:
			velocity.x = 0
			$AnimatedSprite2D.flip_h = not flip
			toA = true

func _physics_process(delta: float) -> void:
	move()
	velocity.y += gravity
	move_and_slide()
	
	if position.distance_to(player.position) < 50:
		$AnimatedSprite2D.play("Attack")
		isAttacking = true
	
	if isAttacking:
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var player = collision.get_collider()
			"""if player is Player and not player.isInvincible:
				player.isInvincible = true
				player.health -= 10
				player.showDamage(1, 10)"""
	
	if hp <= 0:
		$AnimatedSprite2D.play("Death")


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Attack":
		isAttacking = false
	elif $AnimatedSprite2D.animation == "Death":
		queue_free()
