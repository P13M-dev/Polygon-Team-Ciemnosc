extends Line2D

func _process(delta: float) -> void:
	var has_card=$"../Hand".active_card!=null
	if has_card:
		self.visible=true
		var p1=$"../Hand".active_card.global_position
		var p2=get_viewport().get_mouse_position()
		points=PackedVector2Array([p1,p2])
	else:
		self.visible=false
