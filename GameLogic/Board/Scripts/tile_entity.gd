extends Node3D
class_name TileEntity

enum Type{FIRE,PUDDLE,ROCK,FOREST,WIND,ICE,NONE}#potem ich będzie więcej
var resource: TileEntityResource:
	set(value):
		resource=value
		state=value.TileEntityState.new()
		if sprite3D==null:
			sprite3D = Sprite3D.new()
			sprite3D.texture = resource.texture
		add_child(sprite3D)
		sprite3D.rotate_x(-PI/2)
		sprite3D.position = Vector3(0,0.1,resource.sprite_offset*0.0)
		
		sprite3D.pixel_size = 1.0
var state: TileEntityResource.TileEntityState:
	set(value):
		state = value
		value.entity = self
var tile: Tile
var sprite3D: Sprite3D

func die() -> void:
	if tile!=null:
		tile.entities.erase(self)
	queue_free()
