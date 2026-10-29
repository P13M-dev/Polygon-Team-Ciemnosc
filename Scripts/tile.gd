extends Node2D
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
	if effect.sprite2D==null:#tutaj pomyślałem, że może jednak Effect powinien być Nodem...
		effect.sprite2D = Sprite2D.new()
		effect.sprite2D.texture = effect.texture
	add_child(effect.sprite2D)
	effect.sprite2D.position = Vector2(0,effect.sprite_offset)
