extends Node2D



#func _on_mute_pressed() -> void:
	# Toggle mute on or off in AudioManager
	#AudioManager.mute_music(not AudioManager.is_muted)

func _on_back_button_pressed() -> void: #Signal: When BackButton is pressed, it takes back to MainMenu.
	get_tree().change_scene_to_file("res://MainMenu.tscn")
