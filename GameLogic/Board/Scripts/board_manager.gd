extends Node
class_name BoardManager

@warning_ignore("unused_signal")
signal update_board_signal()

const board_width: int = 10
const tile_size: float = 68
const vertical_scale_factor: float = 0.5
var tiles: Array[Array] #powinno być Array[Array[Tile]], ale GDscript nie pozwala :P
var path_find_grid:AStarGrid2D # pathowanie a* 
@export var rock:TileEntityResource
func get_tile(postion:Vector2i)->Tile:
	if postion.x<0:
		return null
	if postion.x>=tiles.size():
		return null
	if postion.y<0:
		return null
	if postion.y>=tiles[postion.x].size():
		return null
	return tiles[postion.x][postion.y]

func _enter_tree() -> void:
	Game.bm=self
@export var fire:TileEntityResource
var is_player_life=true
var is_enemy_life=true
func update_board()->void:
	#this is random placeholder effect 
	#TODO replace with fire spread
	#for x in range(0,board_width):
	#	for y in range(0,board_width):
	#		if randi()%50==0:
	#			tiles[x][y].make_entity(rock)
	for x in range(0,board_width):
		for y in range(0,board_width):
			var pos:Vector2i=Vector2i(x,y)
			var t:Tile=get_tile(pos)
			for e in t.entities:
				e.state.on_tick(e)
			if t.unit!=null:
				t.at=0.0
	for x in range(0,board_width):
		for y in range(0,board_width):
			var pos:Vector2i=Vector2i(x,y)
			var t:Tile=get_tile(pos)
			if t.unit!=null:
				var unit_type:Elemental.Type=t.unit.type
				if unit_type==Elemental.Type.FIRE and t.has_entity(TileEntity.Type.PUDDLE):
					t.unit=null
				if unit_type==Elemental.Type.FOREST and t.has_entity(TileEntity.Type.FIRE):
					t.unit=null
				if unit_type==Elemental.Type.PUDDLE and t.has_entity(TileEntity.Type.FIRE):
					t.unit=null
	var ar:Array[Vector2i]=[]
	for x in range(0,board_width):
		for y in range(0,board_width):
			var pos:Vector2i=Vector2i(x,y)
			var t:Tile=get_tile(pos)
			if t.has_entity(TileEntity.Type.FIRE):
				for n:Vector2i in [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,-1),Vector2i(0,1)]:
					var np:Vector2i=pos+n
					var t2:Tile=get_tile(np)
					if t2!=null:
						for e:TileEntity in t2.entities:
							if e.resource.type==TileEntity.Type.FOREST:
								ar.append(e.state.board_position)
								e.die()
	for p:Vector2i in ar:
		var t2:Tile=get_tile(p)
		t2.make_entity(fire)
	

			
		
				#tiles[x][y].add_effect(preload("res://GameLogic/Board/Resources/TileEffects/rock_effect.tres").duplicate())
	#end placeholder 
	update_unit_pathing()
	move_enemy_units()
	
	for x in range(0,board_width):
		for y in range(0,board_width):
			var pos:Vector2i=Vector2i(x,y)
			var t:Tile=get_tile(pos)
			if t.unit!=null:
				if t.unit.enemy:
					for n:Vector2i in [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,-1),Vector2i(0,1)]:
						var np:Vector2i=pos+n
						var ntile:Tile=get_tile(np)
						if ntile!=null:
							if ntile.unit!=null:
								if not ntile.unit.enemy:
									print("KILLL!!!!!")
									ntile.unit=null
	is_enemy_life=false
	is_player_life=false
	for x in range(0,board_width):
		for y in range(0,board_width):
			var pos:Vector2i=Vector2i(x,y)
			var t:Tile=get_tile(pos)
			if t.unit!=null:
				if t.unit.enemy:
					is_enemy_life=true
				else:
					is_player_life=true
			
func update_unit_pathing() -> void:
	for x in board_width:
		for y in board_width:
			var treversible:bool = tiles[x][y].is_treversible(true)
			if treversible:
				path_find_grid.set_point_solid(Vector2i(x, y),false)
				path_find_grid.set_point_weight_scale(Vector2i(x, y), 2.0)
				# dodaj funkcje aby znajdować pola trudniejsze do przejścia
			else:
				path_find_grid.set_point_solid(Vector2i(x, y),true)





const MAX_TARGETS_TO_TRY: int = 3 

func move_enemy_units() -> void:
	var enemies: Array[Vector2i] = []
	var occupied: Dictionary = {}
	for x: int in tiles.size():
		for y: int in tiles[x].size():
			var unit: Unit = tiles[x][y].unit
			if unit == null:
				continue
			occupied[Vector2i(x, y)] = true
			if unit.enemy:
				enemies.append(Vector2i(x, y))
	var priority: Dictionary = {}
	for pos: Vector2i in enemies:
		var targets: Array[Vector2i] = find_nearest_units(pos.x, pos.y, false)
		priority[pos] = distance(pos, targets[0]) if not targets.is_empty() else 9999
	enemies.sort_custom(func(a: Vector2i, b: Vector2i) -> bool: return priority[a] < priority[b])

	for pos: Vector2i in enemies:
		var unit: Unit = tiles[pos.x][pos.y].unit
		
		var destination: Vector2i = find_destination(pos, unit, occupied)
		if destination == pos: continue
		occupied.erase(pos)
		occupied[destination] = true
		var moved: Unit = tiles[pos.x][pos.y].pop_unit()
		tiles[destination.x][destination.y].add_unit(moved)

func find_destination(from: Vector2i, unit: Unit, occupied: Dictionary) -> Vector2i:
	var targets: Array[Vector2i] = find_nearest_units(from.x, from.y, false)
	print("finded",targets)
	for i: int in mini(targets.size(), MAX_TARGETS_TO_TRY):
		var path: PackedVector2Array = path_find_grid.get_point_path(from, targets[i])
		#var furthest: int = mini(unit.movesPerTurn, path.size() - 2)
		var furthest: int = mini(unit.movesPerTurn, path.size() - 2)#
		for step: int in range(furthest, 0, -1):
			var candidate := Vector2i(path[step])
			if not occupied.has(candidate):
				return candidate
		#if path.size()>0:
		#	return path[1]
	return from

func find_nearest_units(origin_x: int, origin_y: int, unit_team: bool) -> Array[Vector2i]:
	var origin := Vector2i(origin_x, origin_y)
	var result: Array[Vector2i] = []
	for x: int in tiles.size():
		for y: int in tiles[x].size():
			var unit: Unit = tiles[x][y].unit
			if unit != null and unit.enemy == unit_team:
				result.append(Vector2i(x, y))
	result.sort_custom(func(a: Vector2i, b: Vector2i) -> bool:
		return distance(origin, a) < distance(origin, b))
	return result


func distance(a: Vector2i, b: Vector2i) -> int:
	return absi(a.x - b.x) + absi(a.y - b.y)
	
func _init() -> void:
	path_find_grid = AStarGrid2D.new()
	path_find_grid.region = Rect2i(0, 0, board_width, board_width)
	path_find_grid.cell_size = Vector2(1, 1)
	path_find_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	path_find_grid.update()

@export var hero:Unit
@export var enemy:Unit

func _ready() -> void:
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
					if x<3 or x>7 or y<3 or y>7:
						if false:
							tile.make_entity(preload("res://GameLogic/Board/Resources/TileEntities/rock_entity_resource.tres").duplicate())
				elif randi()%10==0:#tutaj są dawane tylko efekty, ale nie ma zmiany stanu pola na cokolwiek
					if false:
						tile.make_entity(preload("res://GameLogic/Board/Resources/TileEntities/water_entity_resource.tres").duplicate())
				#elif randi()%10==0:
				#	tile.add_unit(preload("res://Resources/Units/flame_unit.tres").duplicate())
				#	tile.unit.enemy = true
				
		
		tiles[5][5].add_unit(hero.duplicate())
		var ps:Array[Vector2i]=[
			Vector2i(3,0),Vector2i(6,0),Vector2i(3,9),Vector2i(6,9),
			Vector2i(0,3),Vector2i(0,6),Vector2i(9,3),Vector2i(9,6),
			Vector2i(2,0),Vector2i(7,0),Vector2i(2,9),Vector2i(7,9),
			Vector2i(0,2),Vector2i(0,7),Vector2i(9,2),Vector2i(9,7),
			]
		var eid:int=0
		for e:Unit in $"../GameManager".wave.enemies:
			eid+=1
			var pi:Vector2i=ps[eid]
			tiles[pi.x][pi.y].add_unit(e.duplicate())
