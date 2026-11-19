extends Node3D
class_name Tile

var entities: Array[TileEntity]

func has_entity(type: TileEntity.Type) -> bool:
	for i: TileEntity in entities:
		if i.resource.type==type:
			return true
	return false

func add_entity(entity: TileEntity) -> void:
	if entity.tile!=null:
		entity.tile.entities.erase(entity)
	entity.tile = self
	entities.append(entity)
	entity.position=Vector3.ZERO

func make_entity(resource: TileEntityResource) -> void:
	var entity: TileEntity = TileEntity.new()
	entity.resource = resource
	add_entity(entity)
