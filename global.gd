extends Node

signal lives_changed
signal droplets_changed
signal coins_changed
signal score_changed
signal distance_changed
signal game_over
signal reset_heat_timer

var max_lives := 6
var lives := 6
var max_droplets := 3
var droplets := 3

var high_score := 0
var distance := 1
var coins := 0
var score := 0

func _ready():
	load_data()

func reset_game():
	lives = max_lives
	droplets = max_droplets

	distance = 1
	coins = 0
	score = distance * 17

	lives_changed.emit()
	droplets_changed.emit()
	distance_changed.emit()
	coins_changed.emit()
	score_changed.emit()

	reset_heat_timer.emit()

func add_distance():
	distance += 1
	distance_changed.emit()
	update_score()
	
func add_coin():
	coins += 1
	coins_changed.emit()
	update_score()

func update_score():
	score = distance * 17
	score_changed.emit()

func lose_life():
	if lives > 0:
		lives -= 1
		lives_changed.emit()
	if lives <= 0:
		if score > high_score:
			high_score = score
			save_data()

		game_over.emit()

func lose_droplet():
	if droplets > 0:
		droplets -= 1
		droplets_changed.emit()
	else:
		lose_life()

func add_droplet():
	if droplets < max_droplets:
		droplets += 1
		droplets_changed.emit()

	reset_heat_timer.emit()

const SAVE_PATH = "user://save.dat"

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	file.store_var({
		"high_score": high_score
	})

	file.close()

func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = file.get_var()
	file.close()

	high_score = data.get("high_score", 0)
