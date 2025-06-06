extends Node2D
class_name BuildingManager

signal stick_pick_up_response(pick_up: bool)
signal stick_counter_updated(new_value: int)

@export var source_id = 0
@export var atlas_coordinates = Vector2i(7, 12)
@export var mouse_collider_scn: PackedScene
const MAX_CAPACITY = 30

@onready var tile_map: TileMapLayer = $BuildingTilemap
@onready var preview_tile_map: TileMapLayer = $PreviewTilemap
@onready var preview_active = true
@onready var holded_sticks: int = 0:
	set(value):
		holded_sticks = value
		stick_counter_updated.emit(holded_sticks)


var _block_cost = 3

func add_sticks(sticks_count) -> bool:
	if holded_sticks + sticks_count > MAX_CAPACITY:
		return false

	holded_sticks += sticks_count
	return true


func destroy_block(rid) -> bool:
	return tile_map.destroy_block(rid)


func _ready():
	stick_counter_updated.emit(holded_sticks)

func _physics_process(_delta):
	if preview_active:
		_preview_element()
		_build_block()
		_deconstruct_block()


func _build_block():
	if Input.is_action_just_pressed("mouse_click"):
		var mouse_position = get_global_mouse_position()
		var map_position = tile_map.local_to_map(mouse_position)
		if _check_mouse_collider_occupied(map_position):
			return
		if holded_sticks < _block_cost:
			return
		
		if tile_map.build_block(map_position, source_id, atlas_coordinates):
			holded_sticks -= _block_cost

func _deconstruct_block():
	if Input.is_action_just_pressed("mouse_right_click"):
		if holded_sticks + _block_cost > MAX_CAPACITY:
			return
		var mouse_position = get_global_mouse_position()
		var map_position = tile_map.local_to_map(mouse_position)
		if tile_map.deconstruct_block(map_position):
			holded_sticks += _block_cost


func _preview_element():
	var mouse_position = get_global_mouse_position()
	var map_position = preview_tile_map.local_to_map(mouse_position)
	preview_tile_map.clear()
	preview_tile_map.set_cell(map_position, source_id, atlas_coordinates)


func _on_player_stick_pick_up_requested():
	var pick_up_success = add_sticks(1)
	stick_pick_up_response.emit(pick_up_success)


func _check_mouse_collider_occupied(mouse_position):
	var instance: MouseCollider = mouse_collider_scn.instantiate()
	add_child(instance)
	instance.global_position = tile_map.map_to_local(mouse_position)
	var result = instance.is_area_occupied()
	instance.queue_free()
	return result
