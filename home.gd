extends CanvasLayer

const MAIN_SCENE = preload("res://Scenes/main.tscn")

func _ready():
	NodeGlobal.play_bgm()

func _on_start_button_pressed():
	NodeGlobal.play_click()
	get_tree().change_scene_to_packed(MAIN_SCENE)

func _on_options_button_pressed():
	NodeGlobal.play_click()
	print("Options pressed")
	# later:
	# $Options.visible = true
