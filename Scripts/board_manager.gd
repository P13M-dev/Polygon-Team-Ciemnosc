extends Node2D
class_name BoardManager

const board_width: int = 10
const tile_size: float = 68
const vertical_scale_factor: float = 0.5
var tiles: Array[Array] #powinno być Array[Array[Tile]], ale GDscript nie pozwala :P

func _init() -> void:
	if tiles.is_empty():
		for x in range(0,board_width):
			tiles.append([])
			for y in range(0,board_width):
				var tile: Tile = preload("res://Scenes/empty_tile.tscn").instantiate()
				tiles[x].append(tile)
				add_child(tile)
				var tile_position: Vector2 = Vector2(x*tile_size-board_width*tile_size/2,y*tile_size-board_width*tile_size/2)
				tile_position = tile_position.rotated(PI/4)
				tile_position.y*=vertical_scale_factor
				tile.position = tile_position
				if randi()%10==0:#to jest głównie do testowania czy, i demonstacji jak działa dodawanie efektów do planszy
					tile.add_effect(preload("res://Resources/TileEffects/rock_effect.tres").duplicate())
				elif randi()%10==0:
					tile.add_effect(preload("res://Resources/TileEffects/puddle_effect.tres").duplicate())
