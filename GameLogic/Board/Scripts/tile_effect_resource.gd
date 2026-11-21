extends TileEntityResource
class_name TileEffectResource

@export var squere_texture:Texture2D

class EffectState extends TileEntityState:
	func placed_on(tile: Tile)->void:
		for i: TileEntity.Type in entity.resource.blocked_by:
			if tile.has_entity(i):
				entity.die()
				return
		for i: TileEntity.Type in entity.resource.kills:
			for j: TileEntity in tile.get_entities(i):
				on_kill(j)
				j.die()
		self.board_position=Vector2i(tile.board_position_x,tile.board_position_y)
	
	func on_kill(killed: TileEntity) -> void:
		pass

func create_state()->TileEntityResource.TileEntityState:
	return EffectState.new()

func is_unit()->bool:
	return false
