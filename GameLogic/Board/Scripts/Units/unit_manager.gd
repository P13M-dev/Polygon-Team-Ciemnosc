extends Node

var current_unit_positions:Array[Array] # Array[Array[Unit]]
var requested_positions:Array[Array] # Array[Array[Unit]]

func moveEnemyUnits(tiles:Array[Array]) -> void: #Array[Array[Tile]]
	for x:int in tiles.size():
		for y:int in tiles[x].size():
			var unit:Unit = tiles[x][y].unit
			if	unit!=null and unit.enemy:
				var nearest:Vector2 = find_nearest_unit(tiles,x,y,false) # najbliższa jednostka gracza
				var path:Array[Vector2] = path_find_to_tile(tiles,x,y,nearest.x as int,nearest.y as int)
				var unit_moves:int = unit.movesPerTurn
				#popraw tutaj aby iterować przez requested pola
				while path.size()>0 and unit_moves>0:
					var move:Vector2 = path.pop_at(0) 
					tiles[x][y].pop_unit();
					tiles[x+move.x][y+move.y].add_unit(unit)
					unit_moves -= 1
			else:
				#przyjazny unit
				continue

const neighbor_offsets:Array[Vector2] = [Vector2(-1,0),Vector2(1,0),Vector2(0,-1),Vector2(0,1)]
func path_find_to_tile(tiles:Array[Array] ,x1:int,y1:int,x2:int,y2:int)->Array[Vector2]: #zwraca serię kierunków
	var path:Array[Vector2] = []
	var available_nodes:Array[Vector2] = []
	var visited:Array[Array] = [] # Array[Array[bool]]
	var search_cells:Array[Array] = [] # Array[Array[SeachCell]]
	var found_destination:bool = false
	for	x in tiles.size():
		tiles.append([])
		search_cells.append([])
		for	y in tiles.size():
			tiles[y].append(false)
			search_cells[y].append(SeachCell.new(999999999,0,0))
	visited[x1][y1] = true;
	search_cells[x1][y1] = SeachCell.new(0,x1,y1)
	available_nodes.append(Vector2(x1,y1))
	while available_nodes.size()>0 and not found_destination:
		var node:Vector2 = search_cells.pop_at(0)
		if visited[node.x][node.y]: continue
		visited[node.x][node.y] = true
		for neighbor:Vector2 in neighbor_offsets:
			var neighbor_x:int = (neighbor.x+node.x) as int
			var neighbor_y:int = (neighbor.y+node.y) as int
			if (!(neighbor_x >= 0 and neighbor_x < tiles.size() and neighbor_y >= 0 and neighbor_y < tiles[0].size())):
				continue
			
			if neighbor_x == x2 and neighbor_y == y2:
				found_destination = true;
				search_cells[neighbor_x][neighbor_y].parent_x = node.x;
				search_cells[neighbor_x][neighbor_y].parent_y = node.y;
				# add trace here
				# path = tracePath(costs, endNodeX, endNodeY);
				break;
			if visited[neighbor_x][neighbor_y] or !is_treversible(tiles[node.x][node.y],true): continue
			var g:float = 0 # add obstacle costs here
			var h:float = abs(neighbor_x - x2) + abs(neighbor_y - y2);
			var f:float = g + h;
			if search_cells[neighbor_x][neighbor_y].f > f:
				available_nodes.append(Vector2(neighbor_x,neighbor_y))
				search_cells[neighbor_x][neighbor_y].f = f
				search_cells[neighbor_x][neighbor_y].parent_x = node.x
				search_cells[neighbor_x][neighbor_y].parent_y = node.y
	#ignoruj jednostki swoje, są rozwiązywane w requestach
	return path

func is_treversible(tile:Tile,side_to_ignore:bool) -> bool:
	
	return true
	
func find_nearest_unit(tiles:Array[Array],origin_x:int,origin_y:int,unit_team:bool)->Vector2:
	var nearest_distance: int = 9999
	var nearest_coordinate: Vector2 = Vector2(-1,-1)
	for x:int in tiles.size():
		for y:int in tiles[x].size():
			var distance:int = abs(origin_x-x)+abs(origin_y-y)
			if tiles[x][y].unit.enemy==unit_team and nearest_distance>distance:
				nearest_coordinate = Vector2(x,y)
				nearest_distance = distance
	return nearest_coordinate
