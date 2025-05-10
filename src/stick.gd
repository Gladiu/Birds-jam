class_name Stick
extends Area2D


@export var _sprite: Sprite2D


func pickup() -> void:
	queue_free()


func _ready() -> void:
	# TODO: Moving up and down
	# This don't work ;-;
	#var tween = create_tween()
	#tween.tween_property(
	#	_sprite,
	#	"position",
	#	position + Vector2(0, -10),
	#	10
	#).as_relative().set_trans(Tween.TRANS_SINE)
	pass
