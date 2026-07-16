extends Area3D

@export var sidewalk_height := 0.5

var counted := false

func _on_body_entered(body):
	if body.name == "tao":
		body.global_position.y = sidewalk_height
		
		if !counted:
			counted = true
			Global.add_distance()

func _on_body_exited(body):
	if body.name == "tao":
		body.global_position.y = 0.0
