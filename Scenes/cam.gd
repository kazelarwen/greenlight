extends Camera3D

@export var speed := 2.0

func _physics_process(delta):
	global_position.x += speed * delta
