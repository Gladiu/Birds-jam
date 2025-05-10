extends Node2D
class_name MouseCollider


@onready var area: Area2D = $CheckArea


func is_area_occupied() -> bool:
	for body in area.get_overlapping_bodies():
		if (body is Enemy) or (body is Player):
			return true
	
	return false


func _on_check_area_body_entered(body: Node2D) -> void:
	print(body)
