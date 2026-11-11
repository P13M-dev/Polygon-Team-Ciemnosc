@tool
extends Area3D
class_name Field
@export var near:Array[Node]
@export var r:float=1.7
@export var refresh:bool=false

@export var mat1:BaseMaterial3D
@export var mat2:BaseMaterial3D

enum FieldState{NONE,FIRE,WATER,PLAYER}
var state:FieldState=FieldState.NONE
var is_hover:bool=false

func make_near() -> void:
	near=[]
	for n:Field in get_tree().get_nodes_in_group("Field"):
				if n!=self:
					if n.global_position.distance_to(self.global_position)<r:
						near.append(n)
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		if true:
			refresh=true
		if refresh:
			refresh=false
			make_near()
	var state2obj:Dictionary={
		FieldState.FIRE:$fire,
		FieldState.WATER:$water,
		FieldState.PLAYER:$player,
	}
	for k:int in state2obj.keys():
		state2obj[k].visible=state==k
	
	
	$hover.visible=is_hover

func _ready() -> void:
	make_near()
