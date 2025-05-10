extends CharacterBody2D

const SPEED = 100
const CLIMB_TOP_SPEED = -200
const CLIMB_SPEED = 50

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

var give_up_current_climb = false

func _process(delta) -> void:
	
	velocity.x = -SPEED
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if is_on_wall() and get_last_slide_collision().get_collider() is TileMapLayer \
									and !give_up_current_climb:
		if $ClimbTimeout.time_left == 0:
			$ClimbTimeout.start()
		velocity.y = move_toward(velocity.y, CLIMB_TOP_SPEED, CLIMB_SPEED)
	elif is_on_floor():
		give_up_current_climb = false
	
	$AnimationPlayer.play("Walk")
	move_and_slide()
	


func _on_climb_timeout_timeout():
	give_up_current_climb = true
