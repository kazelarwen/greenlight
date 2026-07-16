extends Node3D

@onready var collectible_points = $collectibles

var coin_scene = preload("res://Scenes/collectibles/coin.tscn")
var water_scene = preload("res://Scenes/collectibles/tubig.tscn")

func _ready():
	randomize()
	spawn_collectibles()

func spawn_collectibles():
	for marker in collectible_points.get_children():

		var roll := randi() % 100
		var scene = null

		if marker.name.begins_with("onRoad"):
			if roll < 60:
				continue
			elif roll < 85:
				scene = coin_scene
			else:
				scene = water_scene

		elif marker.name.begins_with("onSw"):
			if roll < 50:
				continue
			elif roll < 70:
				scene = coin_scene
			else:
				scene = water_scene

		if scene == null:
			continue

		var item = scene.instantiate()
		collectible_points.add_child(item)
		item.global_position = marker.global_position

func _place_collectible(item: Node3D, marker: Marker3D):
	item.global_position = marker.global_position
	item.global_position.y += 0.5
	print(marker.name, " -> ", marker.global_position)
