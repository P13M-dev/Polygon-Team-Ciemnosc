extends CardBase
class_name SpawnCard
@export var spawn:FieldCollider.FieldState
@export var r:int

func cast_on(f:FieldCollider):
	assert(r<3)
	if r==0:
		pass
	if r==1:
		f.state=spawn
	if r==2:
		print("RRRRr")
		f.state=spawn
		f.get_parent().add_effect(preload("res://GameLogic/Board/Resources/TileEffects/rock_effect.tres").duplicate())
		for nf in f.near:
			nf.state=spawn
	
