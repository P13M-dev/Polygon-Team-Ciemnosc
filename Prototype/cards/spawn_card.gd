extends CardBase
class_name SpawnCard
@export var spawn:Field.FieldState
@export var r:int

func cast_on(f:Field):
	assert(r<3)
	if r==0:
		pass
	if r==1:
		f.state=spawn
	if r==2:
		f.state=spawn
		for nf in f.near:
			nf.state=spawn
	
