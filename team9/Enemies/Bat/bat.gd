# Xavier
extends CharacterBody2D

@export var speed = 300
@onready var hasTarget = false
@export var hp = 100
var target
var player
var cd = false
@onready var timer = $Timer

func _physics_process(delta: float) -> void:
	if hasTarget && not cd:
		if position.x > target.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		velocity = position.direction_to(target) * speed
		if position.distance_to(target) <= 10:
			target = player.position
	else:
		velocity = Vector2(0, 0)
		
	if hp <= 0:
		$AnimatedSprite2D.play("Death")
			
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var player = collision.get_collider()
		
		if player is Player:
			#player.health -= 10
			timer.start(2)
			$CollisionShape2D.disabled = true
			cd = true
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_collision_layer() == 2:
		hasTarget = true
		target = body.position
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.get_collision_layer() == 2:
		hasTarget = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Death":
		queue_free()


func _on_timer_timeout() -> void:
	$CollisionShape2D.disabled = false
	cd = false
