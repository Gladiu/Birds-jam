extends Node

const EGGS_CENTER_OF_MASS = Vector2(-216, 456) # TODO: Fetch this info from autoload


func _on_timer_60s_timeout():
	$World.toggle_day_night()
	if $World.current_time == World.TIME_ENUM.DAY:
		# TODO: Change to drop around the eggs average position
		$SticksSpawner.spawn(45, -316, -115, -200, -100)


func _process(delta):
	$World.set_time_factor(1 - ($Timer60s.time_left / $Timer60s.wait_time))
	if Global.eggs.is_empty():
		print("YOU WIN")
