extends Node

var bm:BoardManager
var mouse3d:Mouse3D
var ruch:Node
var hand:Hand

func get_board()->BoardManager:
	assert(bm!=null)
	return bm

func get_mouse_tile()->Tile:
	assert(mouse3d!=null)
	return mouse3d.current_field.get_parent()
