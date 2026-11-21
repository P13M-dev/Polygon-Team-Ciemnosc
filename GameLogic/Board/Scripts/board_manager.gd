extends Node
class_name BoardManager

const board_width: int = 10
const tile_size: float = 68
const vertical_scale_factor: float = 0.5
var tiles: Array[Array] #powinno być Array[Array[Tile]], ale GDscript nie pozwala :P
@export var rock:TileEntityResource
func get_tile(postion:Vector2i)->Tile:
	if postion.x<0:
		return null
	if postion.x>tiles.size():
		return null
	if postion.y<0:
		return null
	if postion.y>tiles[postion.x].size():
		return null
	return tiles[postion.x][postion.y]

func _enter_tree() -> void:
	Game.bm=self

func update_board()->void:
	#this is random placeholder effect 
	#TODO replace with fire spread
	for x in range(0,board_width):
		for y in range(0,board_width):
			if randi()%50==0:
				tiles[x][y].make_entity(rock)

				#tiles[x][y].add_effect(preload("res://GameLogic/Board/Resources/TileEffects/rock_effect.tres").duplicate())
	#end placeholder 
	
func _init() -> void:
	if tiles.is_empty():
		for x in range(0,board_width):
			tiles.append([])
			for y in range(0,board_width):
				var tile: Tile = preload("res://GameLogic/Board/Scenes/empty_tile.tscn").instantiate()
				tile.board_position_x = x
				tile.board_position_y = y
				tile.unit = null
				tiles[x].append(tile)
				add_child(tile)
				var tile_position: Vector2 = Vector2(x*tile_size-board_width*tile_size/2,y*tile_size-board_width*tile_size/2)
				tile_position = tile_position.rotated(PI/4)
				tile_position.y*=vertical_scale_factor
				tile_position=tile_position+Vector2(542.0,348.0)
				tile.position = Vector3(tile_position.x,0,tile_position.y)

				"""
				if randi()%10==0:
					#to jest głównie do testowania czy, i demonstacji jak działa dodawanie efektów do planszy
					tile.add_effect(preload("res://GameLogic/Board/Resources/TileEffects/rock_effect.tres").duplicate())
				elif randi()%10==0:#tutaj są dawane tylko efekty, ale nie ma zmiany stanu pola na cokolwiek
					tile.add_effect(preload("res://GameLogic/Board/Resources/TileEffects/puddle_effect.tres").duplicate())
				elif randi()%10==0:
					tile.add_unit(preload("res://Resources/Units/flame_unit.tres").duplicate())

				"""
				if randi()%10==0:#to jest głównie do testowania czy, i demonstacji jak działa dodawanie efektów do planszy
					tile.make_entity(preload("res://GameLogic/Board/Resources/TileEntities/rock_entity_resource.tres").duplicate())
				elif randi()%10==0:#tutaj są dawane tylko efekty, ale nie ma zmiany stanu pola na cokolwiek
					tile.make_entity(preload("res://GameLogic/Board/Resources/TileEntities/water_entity_resource.tres").duplicate())
				elif randi()%10==0:
					tile.add_unit(preload("res://Resources/Units/flame_unit.tres").duplicate())
