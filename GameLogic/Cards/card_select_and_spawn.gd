extends CardBase
class_name SelectAndSpawnCard
@export var image:Texture2D
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
	#var menu_wigdetw:MenuWidget=library.menu.instantiate()
	#Game.bm.get_parent().add_child(menu_wigdetw)
	var field_widget:CastWidget=library.cast.instantiate()
	Game.bm.get_parent().add_child(field_widget)
	return [menu_wigdet,field_widget]
	
func cast_on(f:FieldCollider) -> void:
	pass


func cast(f:Array[CardCastWidget.WidgetResult]) -> void:
	print("CUTOM CATING")
	var widget_str:MenuWidget.WidgetString=f[0]
	var widget_field:CastWidget.WidgetField=f[1]
	#var t:Tile=v.t
	if widget_str.vaule==enitity1str:
		widget_field.f.get_tile().make_entity(enitity1)
	if widget_str.vaule==enitity2str:
		widget_field.f.get_tile().make_entity(enitity2)
	if widget_str.vaule==enitity3str:
		widget_field.f.get_tile().make_entity(enitity3)
