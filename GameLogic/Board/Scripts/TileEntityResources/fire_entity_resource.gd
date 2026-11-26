extends TileEffectResource
class_name FireEntityResource
@export var burn_time: int

func is_unit()->bool:
	return false

func create_state()->TileEntityResource.TileEntityState:
	return TileEntityState.new()

class TileEntityState:
	extends TileEffectResource.EffectState
	var turns_left: int = 3
	
	func on_tick(t:TileEntity):
		t.get_child(0).pixel_size*=0.8
		turns_left-=1
		if turns_left==0:
			t.die()
		
	
	func placed_on(tile: Tile)->void:
		turns_left += entity.resource.burn_time
		super(tile)
	
	func on_kill(killed: TileEntity) -> void:
		if killed.resource.type==TileEntity.Type.FOREST:
			turns_left += 3#przykład tego, jak mogą działać interakcje pomiędzy TileEnitami
