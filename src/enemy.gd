extends CharacterBody2D



func _process(_delta) -> void:
	var motion = Vector2(-1, 0)
	print(move_and_collide(motion))
