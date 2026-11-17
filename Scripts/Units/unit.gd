extends Resource
class_name Unit

@export var shield_stacks: int = 0
@export var type: Elemental.Type = Elemental.Type.NONE
@export var texture: Texture2D
@export var moves_per_turn:int
@export var attack_range:int
var enemy:bool # potem możemy zrobić jakiś enum jak chcemy neutral team
var sprite3D: Sprite3D
