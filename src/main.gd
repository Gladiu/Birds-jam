extends Node

var egg_spawn_min_x = INF
var egg_spawn_max_x = -INF
var egg_spawn_min_y = -700
var egg_spawn_max_y = -400
var day_count = 0
var base_stick_spawn_count = 20


func _ready() -> void:
	# Find min and max x positions to adjust spread of sticks
	for egg in Global.eggs:
		if egg.position.x < egg_spawn_min_x:
			egg_spawn_min_x = egg.position.x
		if egg.position.x > egg_spawn_max_x:
			egg_spawn_max_x = egg.position.x
	# In case we have only one egg, add bigger spread
	egg_spawn_min_x -= 500
	egg_spawn_max_x += 500



func _on_timer_60s_timeout():
	$World.toggle_day_night()
	if $World.current_time == World.TIME_ENUM.DAY:
		day_count += 1
		$SticksSpawner.spawn(
			day_count * base_stick_spawn_count,
			egg_spawn_min_x,
			egg_spawn_max_x,
			egg_spawn_min_y,
			egg_spawn_max_y
		)


func _process(delta):
	$World.set_time_factor(1 - ($Timer60s.time_left / $Timer60s.wait_time))
	if Global.eggs.is_empty():
		print("YOU WIN")
