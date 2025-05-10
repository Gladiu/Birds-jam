extends CharacterBody2D

const MOVE_SPEED = 10000
const CLIMB_TOP_SPEED = -400
const CLIMB_SPEED = 50
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var _animation: AnimatedSprite2D

enum FacingDirection
{
	LEFT,
	RIGHT
}

var facing_direction: FacingDirection = FacingDirection.RIGHT


func _physics_process(delta: float) -> void:
	# Sideways movement
	var axis = Input.get_axis("move_left", "move_right")
	velocity.x = axis * MOVE_SPEED * delta

	if axis > 0:
		facing_direction = FacingDirection.RIGHT
	elif axis < 0:
		facing_direction = FacingDirection.LEFT
	#else: Nothing

	if not is_on_floor():
		# Apply gravity
		velocity.y += GRAVITY * delta

		# Play flight animation whilst we are in the air
		_animation.play("fly")
	else:
		# If we are not, check if we have velocity.x different than 0
		if velocity.x == 0.0:
			_animation.play("idle")
		else:
			_animation.play("run")

	if facing_direction == FacingDirection.RIGHT:
		_animation.flip_h = true
	else:
		_animation.flip_h = false

	# Fly
	if Input.is_action_pressed("fly"):
		velocity.y = move_toward(velocity.y, CLIMB_TOP_SPEED, CLIMB_SPEED)

	move_and_slide()

	
