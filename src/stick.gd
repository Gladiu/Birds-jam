class_name Stick
extends CharacterBody2D

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

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


func _physics_process(delta: float) -> void:
	# Fall from the sky
	if not is_on_floor():
		velocity.y += GRAVITY * delta / 4.0 # Slow it down
		move_and_slide()

func _on_body_entered(body: Node2D) -> void:
	pass
