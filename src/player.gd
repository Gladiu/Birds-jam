extends CharacterBody2D
class_name Player

signal stick_pick_up_requested

const MOVE_SPEED = 400
const CLIMB_TOP_SPEED = -400
const CLIMB_SPEED = 50
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var _animation: AnimatedSprite2D

enum FacingDirection
{
	LEFT,
	RIGHT
}

var _facing_direction: FacingDirection = FacingDirection.RIGHT
var _stick_to_pick_up: Stick

var _poop_scn: = preload("res://scn/poop.tscn")


func _physics_process(delta: float) -> void:
	# Sideways movement
	var axis = Input.get_axis("move_left", "move_right")
	velocity.x = axis * MOVE_SPEED

	if axis > 0:
		_facing_direction = FacingDirection.RIGHT
	elif axis < 0:
		_facing_direction = FacingDirection.LEFT
	#else: Nothing

	if not is_on_floor():
		# Apply gravity
		velocity.y += GRAVITY * delta / 2.0

		# Play flight animation whilst we are in the air
		_animation.play("fly")
	else:
		# If we are not, check if we have velocity.x different than 0
		if velocity.x == 0.0:
			_animation.play("idle")
		else:
			_animation.play("run")

	# Flip
	if _facing_direction == FacingDirection.RIGHT:
		_animation.flip_h = true
	else:
		_animation.flip_h = false

	# Fly
	if Input.is_action_pressed("fly"):
		velocity.y = move_toward(velocity.y, CLIMB_TOP_SPEED, CLIMB_SPEED)

	move_and_slide()


func _process(_delta: float) -> void:
	# TODO: Maybe signal is not even needed?
	# Double check necessary for case where we are standing on sticks and
	# we have full capacity and we then build something (no enter signal is emitted)
	for body in $PickupRange.get_overlapping_bodies():
		if body as Stick:
			if not _stick_to_pick_up:
				_stick_to_pick_up = body
				stick_pick_up_requested.emit()

	# Poop
	if Input.is_action_just_pressed("poop"):
		var poop: = _poop_scn.instantiate()
		get_tree().root.add_child(poop)
		poop.global_position = global_position
		poop.velocity = velocity


func _on_pickup_range_body_entered(body: Node2D):
	var stick: = body as Stick
	if not stick:
		return

	# Inform manager that we are about to pickup a stick
	_stick_to_pick_up = stick
	stick_pick_up_requested.emit()


func _on_building_manager_stick_pick_up_response(pick_up: bool) -> void:
	# Earlier we requested manager to pickup a stick, here we get response
	if pick_up and _stick_to_pick_up:
		_stick_to_pick_up.pickup()
	_stick_to_pick_up = null
