extends Node

var eggs = []

func add_egg_data(egg_data: EggData):
	eggs.append(egg_data)


func remove_egg(instance_id):
	for egg in eggs:
		if egg.id == instance_id:
			eggs.erase(egg)
			return
