extends Node3D

@export var environments_node: NodePath

var environment_scenes = [
	preload("res://Scenes/1_st.tscn"),
	preload("res://Scenes/2_nd.tscn")
]

var last_environment: Node3D
var last_random := -1

@onready var environments := get_node(environments_node)

func _ready():
	randomize()
	last_environment = environments.get_child(environments.get_child_count() - 1)

func spawn_next_environment():
	var random := randi() % environment_scenes.size()
	while random == last_random:
		random = randi() % environment_scenes.size()
	last_random = random

	var new_environment = environment_scenes[random].instantiate()
	environments.add_child(new_environment)

	var last_end = last_environment.get_node_or_null("EndMarker")
	var new_start = new_environment.get_node_or_null("StartMarker")

	if last_end == null or new_start == null:
		push_error("Missing StartMarker/EndMarker on: " + new_environment.name + " or " + last_environment.name)
		new_environment.queue_free()
		return

	var offset = last_end.global_position - new_start.global_position
	new_environment.global_position += offset
	last_environment = new_environment
