extends Area3D

@export var sidewalk_height := 8.0

func _on_body_entered(body):
	if body.name == "tao":
		body.global_position.y = sidewalk_height

func _on_body_exited(body):
	if body.name == "tao":
		body.global_position.y = 0.0
