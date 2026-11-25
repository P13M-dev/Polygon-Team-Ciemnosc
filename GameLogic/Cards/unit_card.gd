extends CardBase
class_name UnitCard 

@export var unit:Unit
@export var image:Texture2D

func get_widget(library:WidgetLibrary) -> Array[CardCastWidget]:
	var filed_cast:CastWidget=library.cast.instantiate()
	Game.bm.get_parent().add_child(filed_cast)
	var w:Array[CardCastWidget]=[filed_cast]#CardBase.SecelectFieldWidget.new()
	return w
func cast_on(f:FieldCollider):
	pass

func cast_on2(f:FieldCollider):
	var t:Tile=f.get_tile()
	if t.unit==null:
		t.unit=unit.duplicate()

func cast(f:Array[CardCastWidget.WidgetResult]) -> void:
	var v:CastWidget.WidgetField=f[0]
	#var t:Tile=v.t
	cast_on2(v.f)
