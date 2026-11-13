extends CardBase
class_name SpawnCard
@export var spawn:FieldCollider.FieldState
@export var r:int
@export var image:Texture2D
@export var tile:TileEffect

func cast_on(f:FieldCollider):
	assert(r<3)
	if r==0:
		pass
	if r==1:
		f.state=spawn
		if tile!=null:
			f.get_tile().add_effect(tile.duplicate())
	if r==2:
		print("RRRRr")
		f.state=spawn
		#f.get_parent().add_effect(preload("res://GameLogic/Board/Resources/TileEffects/rock_effect.tres").duplicate())
		if tile!=null:
			f.get_tile().add_effect(tile.duplicate())
			print(tile.resource_path)
		for nf in f.near:
			nf.state=spawn
			if tile!=null:
				nf.get_tile().add_effect(tile.duplicate())
	
