extends CardBase
class_name SpawnCard
@export var spawn:FieldCollider.FieldState
@export var r:int
@export var image:Texture2D
@export var tile:TileEntityResource


func get_widget() -> CastWidget:
	var w:=CardBase.SecelectFieldWidget.new()
	return w


func cast_on(f:FieldCollider)->void:
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
			print(tile.resource_path)
		for nf:FieldCollider in f.near:
			nf.state=spawn
			if tile!=null:
				nf.get_tile().make_entity(tile)
	
