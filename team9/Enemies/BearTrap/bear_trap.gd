extends Area2D

func _on_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.play("Activate")

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
