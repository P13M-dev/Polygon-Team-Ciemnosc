extends ColorRect

class_name CardNode


@export var efect:String="XX"

@export var card:CardBase


func _ready() -> void:
	$Label.text=card.name
