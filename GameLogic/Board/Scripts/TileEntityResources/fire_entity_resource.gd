extends TileEntityResource
class_name FireEntityResource
@export var burn_time: int

class TileEntityState:
	extends TileEntityResource.TileEntityState
	var turns_left: int = 0
	
	func placed_on(tile: Tile)->void:
		turns_left += entity.resource.burn_time
		super(tile)
	
	func on_kill(killed: TileEntity) -> void:
		if killed.resource.type==TileEntity.Type.FOREST:
			turns_left += 3#przykład tego, jak mogą działać interakcje pomiędzy TileEnitami
