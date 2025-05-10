extends Node
enum TIME_ENUM {DAY, NIGHT}

var DAY_COLOR = Color.hex(0x66bdffff)
var NIGHT_COLOR = Color.hex(0x000000ff)

var current_time: TIME_ENUM

func _ready() -> void:
	$Sky/ColorRect.color = DAY_COLOR
	current_time = TIME_ENUM.DAY

func toggle_day_night():
	if current_time == TIME_ENUM.DAY:
		current_time = TIME_ENUM.NIGHT
	else:
		current_time = TIME_ENUM.DAY
	
func set_time_factor(factor : float):
	print(factor)
	if current_time == TIME_ENUM.DAY:
		$Sky/ColorRect.color = DAY_COLOR.lerp(NIGHT_COLOR, factor)
	else:
		$Sky/ColorRect.color = NIGHT_COLOR.lerp(DAY_COLOR, factor)
	
	
