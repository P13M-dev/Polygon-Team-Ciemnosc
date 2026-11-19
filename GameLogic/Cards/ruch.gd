extends CardBase
class_name MovementCard

@export var image: Texture2D


func get_widget() -> CastWidget:
	var w:=CardBase.SecelectFieldWidget.new()
	return w

func cast_on(f:FieldCollider) -> void:
	pass

func activate() -> void:
	print("Aktywowano tryb ruchu")
