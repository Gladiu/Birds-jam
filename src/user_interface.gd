class_name UserInterface
extends Control


func _ready() -> void:
	$StickCounterAndCapacity.text = "0/" + str(BuildingManager.MAX_CAPACITY)


func _on_building_manager_stick_counter_updated(new_value: int) -> void:
	$StickCounterAndCapacity.text = str(new_value) + "/" + str(BuildingManager.MAX_CAPACITY)
