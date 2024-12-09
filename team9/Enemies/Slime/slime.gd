extends CharacterBody2D

const SPEED = 100

@onready var player = $"../Player ( Polina)"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var hp = 100
@export var A: Node2D
@export var B: Node2D
@export var flip = true
var toB = false
var isAttacking = false

func _ready() -> void:
	print("A " + str(A.global_position))
	print("B " + str(B.global_position))

func move():
	if toB:
		velocity.x = SPEED
		if position.distance_to(B.position) <= 50:
			velocity.x = 0
			$AnimatedSprite2D.flip_h = flip
			toB = false
	else:
		velocity.x = -SPEED
		if position.distance_to(A.position) <= 50:
			velocity.x = 0
			$AnimatedSprite2D.flip_h = not flip
			toB = true

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
