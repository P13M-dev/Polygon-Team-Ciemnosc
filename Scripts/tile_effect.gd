extends Resource
class_name TileEffect

enum Type{FIRE,PUDDLE,ROCK,FOREST,WIND,ICE}#potem ich będzie więcej
@export var type: Type
@export var texture: Texture2D
@export var sprite_offset: float = 0
var tile: Tile
var sprite2D: Sprite2D
