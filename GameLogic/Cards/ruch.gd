extends CardBase
class_name MovementCard

@export var image: Texture2D


func get_widget(library:WidgetLibrary) -> Array[CardCastWidget]:
	return [library.r]

func cast_on(f:FieldCollider) -> void:
	pass

func activate() -> void:
	print("Aktywowano tryb ruchu")

func cast(f:Array[CardCastWidget.WidgetResult]) -> void:
	var r:RuchManager.RuchData=f[0]
	print("casting movement")
	print("from ",r.from.board_position_x," ",r.from.board_position_y)
	print("to ",r.to.board_position_x," ",r.to.board_position_y)
