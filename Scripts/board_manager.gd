extends Node
class_name BoardManager

const board_width: int = 10
const tile_size: float = 68
const vertical_scale_factor: float = 0.5
var tiles: Array[Array] #powinno być Array[Array[Tile]], ale GDscript nie pozwala :P
var path_find_grid:AStarGrid2D # pathowanie a* 
func _enter_tree() -> void:
	Game.bm=self

func _init() -> void:
	path_find_grid = AStarGrid2D.new()
	path_find_grid.region = Rect2i(0, 0, board_width, board_width)
	path_find_grid.cell_size = Vector2(1, 1)
	path_find_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	path_find_grid.update()
	if tiles.is_empty():
		for x in range(0,board_width):
			tiles.append([])
			for y in range(0,board_width):
				var tile: Tile = preload("res://Scenes/empty_tile.tscn").instantiate()
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
				if randi()%10==0:#to jest głównie do testowania czy, i demonstacji jak działa dodawanie efektów do planszy
					tile.add_effect(preload("res://Resources/TileEffects/rock_effect.tres").duplicate())
				elif randi()%10==0:
					tile.add_effect(preload("res://Resources/TileEffects/puddle_effect.tres").duplicate())
		tiles[0][0].add_unit(preload("res://Resources/Units/flame_unit.tres").duplicate())
		tiles[0][0].unit.enemy = true
		tiles[6][6].add_unit(preload("res://Resources/Units/water_unit.tres").duplicate())
		tiles[6][6].unit.enemy = false

var current_unit_positions:Array[Array] # Array[Array[Unit]]
var requested_positions:Array[Array] # Array[Array[Unit]]

func moveEnemyUnits() -> void: 


	for x in board_width:
		for y in board_width:
			var treversible:bool = tiles[x][y].is_treversible(true)
			if treversible:
				path_find_grid.set_point_solid(Vector2i(x, y),false)
				path_find_grid.set_point_weight_scale(Vector2i(x, y), 2.0)
			else:
				path_find_grid.set_point_solid(Vector2i(x, y),true)
	
	for x:int in board_width:
		for y:int in board_width:
			var unit:Unit = tiles[x][y].unit
			if	unit!=null and unit.enemy:
				var nearest:Vector2 = find_nearest_unit(x,y,false) # najbliższa jednostka gracza
				var path: PackedVector2Array = path_find_grid.get_point_path(Vector2i(x, y), nearest)
				var unit_moves:int = unit.moves_per_turn
				#popraw tutaj aby iterować przez requested pola
				#pamiętaj żeby jednostki zostawały na max range'u
				while path.size()>0 and unit_moves>0:
					var move:Vector2
					tiles[x][y].pop_unit();
					tiles[move.x][move.y].add_unit(unit)
					unit_moves -= 1
			else:
				#przyjazny unit
				continue



func find_nearest_unit(origin_x:int,origin_y:int,unit_team:bool)->Vector2:
	var nearest_distance: int = 9999
	var nearest_coordinate: Vector2 = Vector2(-1,-1)
	for x:int in tiles.size():
		for y:int in tiles[x].size():
			var distance:int = abs(origin_x-x)+abs(origin_y-y)
			if tiles[x][y].unit.enemy==unit_team and nearest_distance>distance:
				nearest_coordinate = Vector2(x,y)
				nearest_distance = distance
	return nearest_coordinate
