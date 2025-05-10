extends TileMapLayer

enum BlockStatus {
	NONE = 0,
	DESTROYED = 1,
	DAMAGED = 2
}

@export var tile_dmg = 25
@export var tile_health = 100


func destroy_block(rid):
	var cords = get_coords_for_body_rid(rid)
	return damage_block(cords, tile_dmg) != BlockStatus.NONE


func set_health(cords, value):
	var cell_data = get_cell_tile_data(cords)
	cell_data.set_custom_data("health", value)


func build_block(map_position, source_id, atlas_coordinates):
	if get_cell_tile_data(map_position):
		return false
	set_cell(map_position, source_id, atlas_coordinates)
	get_cell_tile_data(map_position).set_custom_data("health", tile_health)
	return true


func deconstruct_block(cords):
	return damage_block(cords, tile_health) == BlockStatus.DESTROYED


func damage_block(cords, damage) -> BlockStatus:
	var cell_data = get_cell_tile_data(cords)

	if !cell_data:
		return BlockStatus.NONE

	var health = cell_data.get_custom_data("health")

	health = health - damage

	if health <= 0:
		set_cell(cords, -1) # clear cell
		return BlockStatus.DESTROYED

	set_health(cords, health)
	return BlockStatus.DAMAGED
