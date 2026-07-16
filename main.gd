extends Node3D

func _ready():
	print("Main ready")

	$HeatTimer.timeout.connect(Global.lose_droplet)
	Global.reset_heat_timer.connect(_reset_heat_timer)
	$HeatTimer.start()

func _reset_heat_timer():
	$HeatTimer.start()
