extends Node

var stick_scn = preload("res://scn/stick.tscn")
var enemy_scn = preload("res://scn/enemy.tscn")

var day_count = 0
var base_stick_spawn_count = 20
var base_enemy_spawn_count = 4

var menu: = preload("res://scn/menu.tscn")


func _on_timer_60s_timeout():
	$World.toggle_day_night()

	# At day, destroy enemies
	if $World.current_time == World.TIME_ENUM.DAY:
		for enemy in find_children("*", "Enemy", true, false):
			enemy.queue_free()

	# Pick what to spawn, at night enemies at day sticks
	var entity_to_spawn
	var entity_spawn_count
	if $World.current_time == World.TIME_ENUM.DAY:
		day_count += 1
		entity_to_spawn = stick_scn
		entity_spawn_count = base_stick_spawn_count * day_count
	else:
		entity_to_spawn = enemy_scn
		entity_spawn_count = base_enemy_spawn_count * day_count

	# Actual spawn
	$EntityRandomSpawner.spawn(
		entity_to_spawn,
		entity_spawn_count,
		World.WEST_BOUNDARY,
		World.EAST_BOUNDARY,
		World.SKYBOX_BOUNDARY,
		World.SKYBOX_BOUNDARY + 100
	)


func _process(delta):
	var factor_untill_next_day = 1 - ($Timer60s.time_left / $Timer60s.wait_time)
	$World.set_time_factor(factor_untill_next_day)
	$Timer60s/Sky/Hand.rotation = factor_untill_next_day * 2 * PI
	if Global.eggs.is_empty():
		#queue_free()
		get_tree().change_scene_to_file("res://scn/menu.tscn")
