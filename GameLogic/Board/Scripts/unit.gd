extends Resource
class_name Unit

@export var shield_stacks: int = 0
@export var type: Elemental.Type = Elemental.Type.NONE
@export var texture: Texture2D
@export var modulate:Color
@export var modulate2:Color
@export var moves_per_turn:int #ile pól na ture może przejść
var enemy:bool # potem możemy zrobić jakiś enum jak chcemy neutral team
var sprite3D: Sprite3D
var selected:bool=false
