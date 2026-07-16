extends Area3D

@export var speed := 10.0
@export var move_left := true   
# true = right→left, false = left→right

@export var left_limit := -100.0
@export var right_limit := 100.0

func _physics_process(delta):

	if move_left:
		position.z -= speed * delta
		if position.z < left_limit:
			position.z = right_limit

	else:
		position.z += speed * delta
		if position.z > right_limit:
			position.z = left_limit

func _on_body_entered(body):
	if body.is_in_group("player"):
		var dir = (body.global_position - global_position).normalized()
		body.take_damage(dir)
