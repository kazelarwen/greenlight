extends Area3D

@export var rotate_speed := 2.0
@export var float_height := 0.15
@export var float_speed := 2.0

var start_y

func _ready():
	start_y = position.y
	body_entered.connect(_on_body_entered)

func _process(delta):
	rotate_y(rotate_speed * delta)
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.0 * float_speed) * float_height

func _on_body_entered(body):
	if body.has_method("collect_coin"):
		body.collect_coin()

	queue_free()
