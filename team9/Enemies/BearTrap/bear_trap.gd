# Xavier
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("Activate")
		$AudioStreamPlayer2D.play()
		#body.health -= 30

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
