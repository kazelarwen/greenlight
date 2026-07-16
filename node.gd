extends Node

@onready var bgm = $BGM
@onready var click = $ClickSound

func play_click():
	click.play()

func play_bgm():
	if !bgm.playing:
		bgm.play()

func stop_bgm():
	bgm.stop()
