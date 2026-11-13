extends CardBase
class_name UnitCard 

@export var unit:Unit
@export var image:Texture2D

func cast_on(f:FieldCollider):
	var t:Tile=f.get_tile()
	if t.unit==null:
		t.unit=unit
