extends Resource
class_name TileEntityResource

@export var type: TileEntity.Type
@export var texture: Texture2D
@export var sprite_offset: float = 0


class TileEntityState:
	var hp: int = 0
