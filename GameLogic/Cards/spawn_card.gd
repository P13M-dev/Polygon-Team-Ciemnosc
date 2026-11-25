extends CardBase
class_name SpawnCard
@export var spawn:FieldCollider.FieldState
@export var r:int
@export var image:Texture2D
@export var tile:TileEntityResource


func get_widget(library:WidgetLibrary) -> Array[CardCastWidget]:
	var filed_cast:CastWidget=library.cast.instantiate()
	Game.bm.get_parent().add_child(filed_cast)
	var w:Array[CardCastWidget]=[filed_cast]#CardBase.SecelectFieldWidget.new()
	return w
	
func cast_on(f:FieldCollider)->void:
	pass

func cast_on2(f:FieldCollider)->void:
	assert(r<3)
	if r==0:
		pass
	if r==1:
		f.state=spawn
		if tile!=null:
			f.get_tile().make_entity(tile)
	if r==2:
		print("RRRRr")
		f.state=spawn
		#f.get_parent().make_entity(preload("res://GameLogic/Board/Resources/TileEntities/rock_entity.tres").duplicate())
		if tile!=null:
			f.get_tile().make_entity(tile)
			var place:Tile=f.get_tile()
			print(tile.resource_path)
			var bp:=Vector2i(place.board_position_x,place.board_position_y)
			for vec in [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1),Vector2i(1,1),Vector2i(-1,-1),Vector2i(1,-1),Vector2i(-1,1)]:
				var np:Vector2i=bp+vec
				var t:Tile=Game.bm.get_tile(np)
				if t!=null:
					t.make_entity(tile)
		#for nf:FieldCollider in f.near:
		#	nf.state=spawn
		#	if tile!=null:
		#		nf.get_tile().make_entity(tile)

func cast(f:Array[CardCastWidget.WidgetResult]) -> void:
	var v:CastWidget.WidgetField=f[0]
	#var t:Tile=v.t
	cast_on2(v.f)
