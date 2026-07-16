extends Area3D

@export var speed := 8.0
@export var move_left := true   
# true = right→left, false = left→right

@export var left_limit := -70.0
@export var right_limit := 70.0

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
	if body.has_method("take_damage"):
		body.take_damage()
