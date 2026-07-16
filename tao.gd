extends CharacterBody3D

var invincible := false
@export var max_camera_distance := 8.0
@export var speed := 5.0

@onready var anim = $student/AnimationPlayer
@onready var model = $student
@onready var camera = $"../cam&light"

func _ready():
	anim.play("stand")

func _physics_process(delta):
	velocity = Vector3.ZERO

	if Input.is_action_pressed("left"):
		velocity.z = -speed
		model.rotation_degrees.y = 90
	if Input.is_action_pressed("right"):
		velocity.z = speed
		model.rotation_degrees.y = -90
	if Input.is_action_pressed("down"):
		velocity.x = -speed
		model.rotation_degrees.y = 180
	if Input.is_action_pressed("up"):
		velocity.x = speed
		model.rotation_degrees.y = 0

	# Play animation
	if velocity != Vector3.ZERO:
		if anim.current_animation != "walk":
			anim.play("walk")
	else:
		if anim.current_animation != "stand":
			anim.play("stand")

	if camera.global_position.x - global_position.x > max_camera_distance:
		Global.game_over.emit()

	move_and_slide()

func collect_water():
	Global.add_droplet()

func collect_coin():
	Global.add_coin()

func take_damage(hit_direction: Vector3):
	if invincible:
		return
	invincible = true
	
	Global.lose_life()

	# Knockback
	global_position += hit_direction * 1.5

	# Flash
	visible = false
	await get_tree().create_timer(0.10).timeout
	visible = true
	await get_tree().create_timer(0.10).timeout
	visible = false
	await get_tree().create_timer(0.10).timeout
	visible = true
	await get_tree().create_timer(0.10).timeout
	visible = false
	await get_tree().create_timer(0.10).timeout
	visible = true

	await get_tree().create_timer(1.0).timeout
	invincible = false
