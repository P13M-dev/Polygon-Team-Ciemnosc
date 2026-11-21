extends ColorRect

class_name CardNode


@export var efect:String="XX"

@export var card:CardBase


func _ready() -> void:
	$Label.text=card.name
	if $TextureRect2!=null:
		$TextureRect2.texture=card.image
	if  $Label2!=null:
		$Label2.text=card.description
	if card.card_image!=null:
		$TextureRect.texture=card.card_image
	$Label.add_theme_color_override("font_color",card.font_color)
	$Label2.add_theme_color_override("default_color",card.font_color)
