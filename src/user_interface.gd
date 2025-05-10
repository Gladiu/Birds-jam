class_name UserInterface
extends Control

# TODO: building manager should have capacity that we will refer to here
const MAX_CAPACITY = 30

func _ready() -> void:
	$StickCounterAndCapacity.text = "0/" + str(MAX_CAPACITY)


func _on_stick_counter_updated(new_value: int) -> void:
	$StickCounterAndCapacity.text = str(new_value) + "/" + str(MAX_CAPACITY)
