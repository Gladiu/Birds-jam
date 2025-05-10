class_name Poop
extends CharacterBody2D

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	$Sprite2D.rotation = velocity.angle() - 0.5 * PI # This offset is necessary
	move_and_slide()
