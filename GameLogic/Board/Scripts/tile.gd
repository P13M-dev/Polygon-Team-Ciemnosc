extends Node3D
class_name Tile


var effects: Array[TileEffect]
var unit: Unit = null
var board_position_x: int
var board_position_y: int


func has_effect(type: Elemental.Type) -> bool:
	for i in effects:
		if i.type==type:
			return true
	return false

func add_effect(effect: TileEffect) -> void:
	if effect.tile!=null:
		effect.tile.effects.erase(effect)
	effect.tile = self
	effects.append(effect)
	if effect.sprite3D==null: #tutaj pomyślałem, że może jednak Effect powinien być Nodem...
		effect.sprite3D = Sprite3D.new()
		effect.sprite3D.texture = effect.texture
	add_child(effect.sprite3D)
	effect.sprite3D.position = Vector3(0,0.1,effect.sprite_offset)
	effect.sprite3D.rotate_x(-PI/2)
	effect.sprite3D.pixel_size=1.0

func add_unit(newUnit: Unit) -> void:
	unit = newUnit;
	if unit.sprite3D==null:
		unit.sprite3D = Sprite3D.new()
		unit.sprite3D.texture = unit.texture
	add_child(unit.sprite3D)
	unit.sprite3D.position = Vector3(0,2,0)
	unit.sprite3D.rotate_x(-PI/2)
	unit.sprite3D.pixel_size=0.02
	

func pop_unit() -> Unit:
	remove_child(unit.sprite3D);
	var u:Unit = unit
	unit = null;
	return u;

# niedokończona funkcja alert vvv
func is_treverisble()-> bool:
	return true

func _process(delta: float) -> void:
	if unit!=null:
		$Sprite3D.texture=unit.texture
		$Sprite3D.visible=true
	else:
		$Sprite3D.visible=false
