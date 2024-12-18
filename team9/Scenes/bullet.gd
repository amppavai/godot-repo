
extends Node2D

@export var speed = 300.0  # Bullet speed
@export var lifetime = 2.0  # Bullet lifetime in seconds

func _ready():
	 # Use await to delete the bullet after its lifetime
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	# Move the bullet forward
	position += Vector2(speed * delta, 0).rotated(rotation)
