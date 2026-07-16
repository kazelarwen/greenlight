extends CanvasLayer

var heart_images = {
	6: preload("res://assets/status/h3.png"),
	5: preload("res://assets/status/h3half.png"),
	4: preload("res://assets/status/h2.png"),
	3: preload("res://assets/status/h2half.png"),
	2: preload("res://assets/status/h1.png"),
	1: preload("res://assets/status/h1half.png"),
	0: preload("res://assets/status/h0.png")
}

var droplet_images = {
	3: preload("res://assets/status/d3.png"),
	2: preload("res://assets/status/d2.png"),
	1: preload("res://assets/status/d1.png"),
	0: preload("res://assets/status/d0.png")
}

func _ready():
	$GameOver.visible = false
	$Pause.visible = false
	$Uhaw.visible = false

	# Low health effect starts invisible
	$LowHealth.visible = true
	$LowHealth.modulate.a = 0.0

	Global.lives_changed.connect(update_hearts)
	Global.droplets_changed.connect(update_droplets)

	Global.coins_changed.connect(update_coins)
	Global.distance_changed.connect(update_distance)
	Global.score_changed.connect(update_score)

	Global.game_over.connect(game_over)

	update_hearts()
	update_droplets()
	update_coins()
	update_distance()
	update_score()

# HEARTS
func update_hearts():
	$Panel/Hearts.texture = heart_images[Global.lives]

	# Fade low health effect
	var tween = create_tween()

	if Global.lives <= 1:
		tween.tween_property($LowHealth, "modulate:a", 0.45, 0.4)
	else:
		tween.tween_property($LowHealth, "modulate:a", 0.0, 0.4)

# DROPLETS
func update_droplets():
	$Panel/Droplets.texture = droplet_images[Global.droplets]

	if Global.droplets <= 1:
		$Uhaw.visible = true
	else:
		$Uhaw.visible = false

# COINS
func update_coins():
	$Panel2/CoinInfo/CoinLabel.text = str(Global.coins)

# DISTANCE
func update_distance():
	$Panel3/DistanceLabel.text = str(Global.distance) + " km"

# SCORE
func update_score():
	$Panel3/ScoreLabel.text = str(Global.score)

# PAUSE
func toggle_pause():
	if $GameOver.visible:
		return

	$Pause.visible = !$Pause.visible
	get_tree().paused = $Pause.visible

func _on_pause_button_pressed():
	print("PAUSE BUTTON CLICKED")
	toggle_pause()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and !event.is_echo():
		toggle_pause()

# RESUME
func _on_resume_button_pressed():
	$Pause.visible = false
	get_tree().paused = false

# RESTART
func _on_restart_button_pressed():
	get_tree().paused = false
	Global.reset_game()
	get_tree().reload_current_scene()

# MENU
func _on_menu_button_pressed():
	get_tree().paused = false
	Global.reset_game()
	get_tree().change_scene_to_file("res://Scenes/home.tscn")

# GAME OVER
func game_over():
	$GameOver.visible = true

	if Global.score >= Global.high_score:
		$GameOver/GameOverModal/Score/ScoreStatement.text = "NEW PERSONAL BEST"
	else:
		$GameOver/GameOverModal/Score/ScoreStatement.text = "CURRENT BEST : " + str(Global.high_score)

	$GameOver/GameOverModal/Score/ScoreLabel.text = str(Global.score)
	$GameOver/GameOverModal/CoinInfo/CoinLabel.text = str(Global.coins)
	$GameOver/GameOverModal/DistanceLabel.text = str(Global.distance) + " km"

	get_tree().paused = true
