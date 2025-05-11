class_name EntityDropSpawner
extends Node


func spawn(scn: PackedScene, count: int, x_min: float, x_max: float, y_min: float, y_max: float):
	assert(x_min <= x_max and y_min <= y_max)
	for _i in range(count):
		var stick: = scn.instantiate()
		add_child(stick)
		stick.global_position = Vector2(randf_range(x_min, x_max), randf_range(y_min, y_max))
