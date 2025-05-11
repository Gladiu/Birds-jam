class_name Enemy
extends CharacterBody2D

const SPEED = 100
const CLIMB_TOP_SPEED = -200
const CLIMB_SPEED = 50
const RANGE = 75

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

var give_up_current_climb = false

var found_egg = false
var egg = null




func _process(delta) -> void:
	var closest_pos = null
	if found_egg:
		velocity.x = 0
		$AnimationPlayer.play("Attack")
		$Sprite2D.modulate = Color.WHITE.lerp(Color.RED, 1 - $EggDestroyCounter.time_left / $EggDestroyCounter.wait_time)
	elif !Global.eggs.is_empty():
		closest_pos = Global.eggs[0].position
		
		for e in Global.eggs:
			if position.distance_to(e.position) < position.distance_to(closest_pos):
				closest_pos = e.position
		velocity.x = -SPEED * (position - closest_pos).normalized().x
		
		
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if closest_pos != null:
		$RayCast2D.target_position = position.direction_to(closest_pos).normalized()*RANGE
		if is_on_wall() and get_last_slide_collision().get_collider() is TileMapLayer and !give_up_current_climb:
			if $ClimbTimeout.time_left == 0:
				$ClimbTimeout.start()
			
			velocity.y = move_toward(velocity.y, CLIMB_TOP_SPEED, CLIMB_SPEED)
		else:
			give_up_current_climb = false
	
		

	if found_egg:
		$AnimationPlayer.play("Attack")
	else:
		$AnimationPlayer.play("Walk")
	move_and_slide()
	


func _on_climb_timeout_timeout():
	give_up_current_climb = true


func _on_area_2d_area_entered(area):
	print("Found egg!")
	egg = area
	found_egg = true
	$EggDestroyCounter.start()
	$Eat/EggEatingSound.start()

func _on_area_2d_area_exited(area):
	egg = null
	print("Lost egg")
	found_egg = false
	$Sprite2D.modulate = Color.WHITE
	$EggDestroyCounter.stop()
	$Eat/EggEatingSound.stop()
	$EggDestroyCounter.wait_time = 5


func _on_egg_destroy_counter_timeout():
	

	found_egg = false
	$Sprite2D.modulate = Color.WHITE
	$EggDestroyCounter.stop()
	$Eat/EggEatingSound.stop()
	$EggDestroyCounter.wait_time = 5
	egg.destroy_egg()
	egg = null


func _on_destroy_timeout_timeout():
	if $RayCast2D.get_collider() != null:
		var tilemap = $RayCast2D.get_collider() as BuildingTileMap
		var cell = tilemap.local_to_map($RayCast2D.get_collision_point() - $RayCast2D.get_collision_normal())
		var tile_id = tilemap.get_cell_source_id(cell)
		tilemap.destroy_block(cell)


func _on_egg_eating_sound_timeout():
	$Eat.play()
