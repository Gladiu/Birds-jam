extends CharacterBody2D

const MOVE_SPEED = 10000
const CLIMB_TOP_SPEED = -400
const CLIMB_SPEED = 50
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Sideways movement
	velocity.x = Input.get_axis("move_left", "move_right") * MOVE_SPEED * delta

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Fly
	if Input.is_action_pressed("fly"):
		velocity.y = move_toward(velocity.y, CLIMB_TOP_SPEED, CLIMB_SPEED)

	move_and_slide()

	
