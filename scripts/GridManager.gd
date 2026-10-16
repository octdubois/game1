class_name GridManager
extends Node

@export var map_size: Vector2i = Vector2i(0, 0)
@export var tile_map_layer: TileMapLayer = null
@export var terrain_database: Dictionary = {}

func is_within_bounds(coords: Vector2i) -> bool:
	return coords.x >= 0 and coords.x < map_size.x and coords.y >= 0 and coords.y < map_size.y

func get_terrain_at(coords: Vector2i) -> TerrainData:
	if not is_within_bounds(coords):
		return null

	if tile_map_layer == null:
		return null

	var atlas_coords: Vector2i = tile_map_layer.get_cell_atlas_coords(coords)

	if terrain_database.has(atlas_coords):
		return terrain_database[atlas_coords]

	return null

func get_movement_cost(coords: Vector2i, unit_type: String) -> int:
	var terrain: TerrainData = get_terrain_at(coords)

	if terrain == null:
		return 999

	if unit_type == "vehicle" and not terrain.is_passable_for_vehicles:
		return 999

	if terrain.movement_costs.has(unit_type):
		return terrain.movement_costs[unit_type]

	return 999
