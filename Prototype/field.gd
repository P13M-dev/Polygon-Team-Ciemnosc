@tool
extends Area3D
class_name Field
@export var near:Array[Node]
@export var r:float=1.7
@export var refresh=false

@export var mat1:BaseMaterial3D
@export var mat2:BaseMaterial3D

enum FieldState{NONE,FIRE,WATER}
var state:FieldState=FieldState.NONE
var is_hover=false

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if true:
			refresh=true
		if refresh:
			refresh=false
			near=[]
			for n:Field in get_tree().get_nodes_in_group("Field"):
				if n!=self:
					if n.global_position.distance_to(self.global_position)<r:
						near.append(n)
	$fire.visible=(state==FieldState.FIRE)
	$water.visible=(state==FieldState.WATER)
	$hover.visible=is_hover
