extends Node3D

@export var environments_node: NodePath

var environment_scenes = [
	preload("res://Scenes/environments/environment_1.tscn"),
	preload("res://Scenes/environments/environment_2.tscn"),
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

	var last_end: Marker3D = last_environment.get_node("EndMarker")
	var new_start: Marker3D = new_environment.get_node("StartMarker")

	var offset = last_end.global_position - new_start.global_position
	new_environment.global_position += offset

	last_environment = new_environment
