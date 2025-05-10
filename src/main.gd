extends Node



func _on_timer_60s_timeout():
	$World.toggle_day_night()

func _process(delta):
	$World.set_time_factor(1 - ($Timer60s.time_left / $Timer60s.wait_time))
