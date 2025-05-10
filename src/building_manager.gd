extends Node2D

@export var ground_layer = 1
@export var source_id = 0
@export var atlas_coordinates = Vector2i(11, 34)

@onready var tile_map: TileMapLayer = $BuildingTilemap
@onready var preview_tile_map: TileMapLayer = $PreviewTilemap
@onready var preview_active = true

func _ready():
	pass


func _physics_process(_delta):
	if preview_active:
		_preview_element()
		_build_block()


func _build_block():
	if Input.is_action_just_pressed("mouse_click"):
		var mouse_position = get_global_mouse_position()
		var map_position = tile_map.local_to_map(mouse_position)
		tile_map.set_cell(map_position, source_id, atlas_coordinates)


func _preview_element():
	var mouse_position = get_global_mouse_position()
	var map_position = preview_tile_map.local_to_map(mouse_position)
	preview_tile_map.clear()
	preview_tile_map.set_cell(map_position, source_id, atlas_coordinates)
