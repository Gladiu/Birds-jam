extends Node2D
class_name EggNest


signal egg_destroyed;


func _ready():
	pass


func destroy_egg():
	queue_free()
	egg_destroyed.emit()
