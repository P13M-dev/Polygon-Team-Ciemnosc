extends Node3D
class_name Tile

var entities: Array[TileEntity]

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
