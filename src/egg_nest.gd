extends Area2D
class_name EggNest


signal egg_destroyed(instance_id)
signal egg_created(instance_id)


func _ready():
	egg_created.connect(Global.add_egg_data)
	egg_destroyed.connect(Global.remove_egg)
	var egg_data: EggData = EggData.new()
	egg_data.id = get_instance_id()
	egg_data.position = global_position
	egg_created.emit(egg_data)


func destroy_egg():
	var instance_id = get_instance_id()
	queue_free()
	egg_destroyed.emit(instance_id)
