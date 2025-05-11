class_name UserInterface
extends Control

var day_counter: = 0

func _ready() -> void:
	$StickCounterAndCapacity.text = "Sticks: 0/" + str(BuildingManager.MAX_CAPACITY)


func _on_building_manager_stick_counter_updated(new_value: int) -> void:
	$StickCounterAndCapacity.text = "Sticks: " + str(new_value) + "/" + str(BuildingManager.MAX_CAPACITY)


func _on_world_daytime_switched(current: World.TIME_ENUM):
	if current == World.TIME_ENUM.DAY:
		$DaytimePlayer2D.play()
		day_counter += 1
		$PhaseIndicator.text = "Phase: Day - build defenses"
		$DayCounter.text = "Day: " + str(day_counter)
	else:
		$NighttimePlayer2D.play()
		$PhaseIndicator.text = "Phase: Night - defend your Eggs!"
