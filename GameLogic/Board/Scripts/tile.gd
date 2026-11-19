extends Node3D
class_name Tile

var entities: Array[TileEntity]
var board_position_x:int=-1
var board_position_y:int=-1
var unit:Unit

func add_unit(u:Unit)->void:
	self.unit=u

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

func make_entity(resource: TileEntityResource) -> void:
	var entity: TileEntity = TileEntity.new()
	entity.resource = resource
	add_entity(entity)


func _process(_delta: float) -> void:
	if unit==null:
		$Sprite3D2.visible=false
	else:
		print("uu")
		$Sprite3D2.visible=true
		#$Sprite3D2.texture=unit.texture
