extends Node3D
class_name Tile

var effects: Array[TileEffect]

func has_effect(type: TileEffect.Type) -> bool:
	for i in effects:
		if i.type==type:
			return true
	return false

func add_effect(effect: TileEffect) -> void:
	if effect.tile!=null:
		effect.tile.effects.erase(effect)
	effect.tile = self
	effects.append(effect)
	if effect.sprite3D==null:#tutaj pomyślałem, że może jednak Effect powinien być Nodem...
		effect.sprite3D = Sprite3D.new()
		effect.sprite3D.texture = effect.texture
	add_child(effect.sprite3D)
	effect.sprite3D.position = Vector3(0,0.1,effect.sprite_offset)
	effect.sprite3D.rotate_x(-PI/2)
	effect.sprite3D.pixel_size=1.0
