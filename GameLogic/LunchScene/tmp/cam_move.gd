extends Camera3D

var dir=1.0
var rot:float=0.0

func _ready() -> void:
	rot=rotation.x

func _process(delta: float) -> void:
	if (rotation.x-rot)*dir<(0.5+0.4*dir):
		rotate_x(delta*dir)
	else:
		dir*=-1
