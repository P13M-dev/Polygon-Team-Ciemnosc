extends Node
class_name SearchCell
var cost:float
var x_parent:int
var y_parent:int

func _init(_cost:float,_x_parent:int,_y_parent:int)->void:
	cost = _cost
	x_parent = _x_parent
	y_parent = _y_parent
