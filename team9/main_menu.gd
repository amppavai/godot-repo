#File by Yolanda Vera Salmeron
extends CanvasLayer

func _on_start_button_pressed() -> void: #Signal: When StartButton is pressed, it takes you to the Level 1.
	#print("Scene change triggered!")
	get_tree().change_scene_to_file("res://parallax_level1.tscn")

func _on_options_button_pressed() -> void: #Signal: When OptionsButton is pressed, it takes you to the Options page.
	get_tree().change_scene_to_file("res://UI/Options.tscn") 


func _on_credits_button_pressed() -> void: #Signal: When CreditsButton is pressed, it takes you to the Credits Page.
	get_tree().change_scene_to_file("res://UI/Credits.tscn")


func _on_exit_button_pressed() -> void: #Signal: When ExitButton is pressed, you exit the game.
	get_tree().quit()
