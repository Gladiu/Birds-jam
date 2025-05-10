class_name SticksSpawner
extends Node

var stick_scn: = preload("res://scn/stick.tscn")


func spawn(count: int, x_min: float, x_max: float, y_min: float, y_max: float):
	assert(x_min <= x_max and y_min <= y_max)
	for _i in range(count):
		var stick: = stick_scn.instantiate() as Stick
		add_child(stick)
		stick.global_position = Vector2(randf_range(x_min, x_max), randf_range(y_min, y_max))
