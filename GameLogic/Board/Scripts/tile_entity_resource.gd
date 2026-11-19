extends Resource
class_name TileEntityResource#meant to be inherited from

@export var type: TileEntity.Type
@export var texture: Texture2D
@export var sprite_offset: float = 0
@export var blocked_by: Array[TileEntity.Type]
@export var kills: Array[TileEntity.Type]

class TileEntityState:
	var entity:TileEntity
	
	func placed_on(tile: Tile)->void:
		for i: TileEntity.Type in entity.resource.blocked_by:
			if tile.has_entity(i):
				entity.die()
				return
		for i: TileEntity.Type in entity.resource.kills:
			for j: TileEntity in tile.get_entities(i):
				on_kill(j)
				j.die()
	
	func on_kill(killed: TileEntity) -> void:
		pass
