class_name World
extends Node

signal daytime_switched(current: TIME_ENUM)

const WEST_BOUNDARY = -2688
const EAST_BOUNDARY = 9275.25
const SKYBOX_BOUNDARY = -5616

enum TIME_ENUM {DAY, NIGHT}

var DAY_COLOR = Color.hex(0x66bdffff)
var NIGHT_COLOR = Color.hex(0x172e63ff)

var current_time: TIME_ENUM = TIME_ENUM.NIGHT

func _ready() -> void:
	$Sky/ColorRect.color = DAY_COLOR
	toggle_day_night()

func toggle_day_night():
	if current_time == TIME_ENUM.DAY:
		current_time = TIME_ENUM.NIGHT
	else:
		current_time = TIME_ENUM.DAY
	daytime_switched.emit(current_time)


func set_time_factor(factor : float):
	if current_time == TIME_ENUM.DAY:
		$Sky/ColorRect.color = DAY_COLOR
	else:
		$Sky/ColorRect.color = NIGHT_COLOR
		
	
	
