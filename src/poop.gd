class_name Poop
extends CharacterBody2D

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	$Sprite2D.rotation = velocity.angle() - 0.5 * PI
	move_and_slide()


func _on_hitbox_body_entered(body):
	var enemy = body as Enemy
	if enemy:
		enemy.queue_free()
	queue_free()
