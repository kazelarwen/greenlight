extends CanvasLayer

const MAIN_SCENE = preload("res://Scenes/main.tscn")

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(MAIN_SCENE)

func _on_options_button_pressed():
	print("Options pressed")
	# later:
	# $Options.visible = true
