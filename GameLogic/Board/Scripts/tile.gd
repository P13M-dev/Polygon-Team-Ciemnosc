extends Node3D
class_name Tile

var entities: Array[TileEntity]
var board_position_x:int=-1
var board_position_y:int=-1
#var unit:UnitEntityResource.UnitState
var unit:Unit

#func add_unit(u:UnitEntityResource)->void:
#	self.unit=u.UnitState.new()
func add_unit(u:Unit)->void:
	self.unit=u
func pop_unit()->Unit:
	print("POP!!!!!!!!!!!!!!!111")
	var u:Unit = unit
	unit = null
	return u

func has_entity(type: TileEntity.Type) -> bool:
	for i: TileEntity in entities:
		if i.resource.type==type:
			return true
	return false

func get_entity(type: TileEntity.Type) -> TileEntity:
	for i: TileEntity in entities:
		if i.resource.type==type:
			return i
	return null

func get_entities(type: TileEntity.Type) -> Array[TileEntity]:
	var result: Array[TileEntity]
	for i: TileEntity in entities:
		if i.resource.type==type:
			result.append(i)
	return result

func add_entity(entity: TileEntity) -> void:
	if entity.tile!=null:
		entity.tile.entities.erase(entity)
	entity.tile = self
	entity.position=Vector3.ZERO
	entities.append(entity)
	self.add_child(entity)
	entity.state.placed_on(entity.tile)
	

func make_entity(resource: TileEntityResource) -> void:
	var entity: TileEntity = TileEntity.new()
	entity.resource = resource
	add_entity(entity)

func is_treversible(ignore_enemy_units:bool)->bool:
	
	return not has_entity(TileEntity.Type.ROCK)
var at:=1.0
func _process(delta: float) -> void:
	if unit==null:
		$Sprite3D2.visible=false
	else:
		#print("uu")
		at+=delta
		$Sprite3D2.visible=true
		if unit.attack_texture!=null and at<2.0:
			$Sprite3D2.texture=unit.attack_texture
		else:
			$Sprite3D2.texture=unit.texture
		#$Sprite3D2.texture=unit.texture if (at>1.0 or unit.attack_texture==null) else unit.attack_texture
		$Sprite3D2.modulate=unit.modulate2 if unit==Game.ruch.player_unit else unit.modulate
		#$Sprite3D2.texture=unit.texture
