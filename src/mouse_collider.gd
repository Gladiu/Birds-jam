extends Node2D
class_name MouseCollider


@onready var raycast = $Check


func is_area_occupied() -> bool:
	raycast.force_shapecast_update()
	return raycast.is_colliding()
