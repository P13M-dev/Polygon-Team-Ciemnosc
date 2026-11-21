@abstract
extends Resource
class_name TileEntityResource#meant to be inherited from

@export var type: TileEntity.Type
@export var texture: Texture2D
@export var sprite_offset: float = 0
@export var blocked_by: Array[TileEntity.Type]
@export var kills: Array[TileEntity.Type]

@abstract
func is_unit()->bool

@abstract
func create_state()->TileEntityResource.TileEntityState
@abstract
class TileEntityState:
	var entity:TileEntity
	var board_position:Vector2i
	@abstract
	func placed_on(tile: Tile)->void
	@abstract
	func on_kill(killed: TileEntity) -> void
