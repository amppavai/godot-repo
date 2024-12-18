# Xavier
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.get_collision_layer() == 2:
		"""
		body.onFire = true
		"""
		pass
