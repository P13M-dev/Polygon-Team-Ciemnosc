extends CardBase
class_name CastAndMoveCard

@export var image: Texture2D
@export var enitity1:TileEffectResource
@export var enitity1str:String
@export var enitity2:TileEffectResource
@export var enitity2str:String
@export var enitity3:TileEffectResource
@export var enitity3str:String

func get_widget(library:WidgetLibrary) -> Array[CardCastWidget]:
	var menu_wigdet:MenuWidget=library.menu.instantiate()
	Game.bm.get_parent().add_child(menu_wigdet)
	menu_wigdet.option=[enitity1str,enitity2str,enitity3str]
	return [library.r,menu_wigdet]

func cast_on(f:FieldCollider) -> void:
	pass

func activate() -> void:
	print("Aktywowano tryb ruchu")

func cast(f:Array[CardCastWidget.WidgetResult]) -> void:
	var r:RuchManager.RuchData=f[0]
	print("casting movement")
	print("from ",r.from.board_position_x," ",r.from.board_position_y)
	print("to ",r.to.board_position_x," ",r.to.board_position_y)
	var widget_str:MenuWidget.WidgetString=f[1]
	if widget_str.vaule==enitity1str:
		r.from.make_entity(enitity1)
	if widget_str.vaule==enitity2str:
		r.from.make_entity(enitity2)
	if widget_str.vaule==enitity3str:
		r.from.make_entity(enitity3)
