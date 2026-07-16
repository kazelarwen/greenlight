extends Area3D

var used := false

func _on_body_entered(body):

	if !body.is_in_group("player"):
		return

	if used:
		return

	used = true

	get_node("/root/main/EnvironmentManager").spawn_next_environment()
