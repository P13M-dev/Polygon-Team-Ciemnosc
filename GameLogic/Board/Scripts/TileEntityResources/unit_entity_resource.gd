extends TileEntityResource
class_name UnitEntityResource
 #NOT IMPLEMENTED

@export var shield_stacks: int = 0
@export var modulate:Color
@export var modulate2:Color
@export var movesPerTurn:int #ile pól na ture może przejść
var enemy:bool # potem możemy zrobić jakiś enum jak chcemy neutral team
var sprite3D: Sprite3D
var selected:bool=false

func create_state()->TileEntityResource.TileEntityState:
	return UnitState.new()

func is_unit()->bool:
	return false

class UnitState:
	extends TileEntityResource.TileEntityState
	var turns_left: int = 0
	
	func on_tick(tileEnitity: TileEntity) -> void:
		pass
	
	func placed_on(tile: Tile)->void:
		turns_left += entity.resource.burn_time
		#super(tile) #TODO CHANGE TO MOR NORMAL ENTINTY
		#tile.unit=self
	
	func on_kill(killed: TileEntity) -> void:
		if killed.resource.type==TileEntity.Type.FOREST:
			turns_left += 3#przykład tego, jak mogą działać interakcje pomiędzy TileEnitami
	
