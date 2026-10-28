@tool
extends Area2D

class_name Field2D

@export var near:Array[Node]
@export var r:float=1.7
@export var refresh=false
var state:Field.FieldState=Field.FieldState.NONE
var is_hover=false

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if true:
			refresh=true
		if refresh:
			refresh=false
			near=[]
			for n:Field2D in get_tree().get_nodes_in_group("Field"):
				if n!=self:
					if n.global_position.distance_to(self.global_position)<r:
						near.append(n)
	$fire.visible=(state==Field.FieldState.FIRE)
	$water.visible=(state==Field.FieldState.WATER)
	$hover.visible=is_hover
