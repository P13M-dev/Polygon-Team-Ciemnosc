extends Resource
class_name TileEffect

@export var type: Elemental.Type
@export var texture: Texture2D
@export var sprite_offset: float = 0
var tile: Tile
var sprite3D: Sprite3D
var change_into:  Elemental.Type
