extends Line2D

func _process(_delta: float) -> void:
	var has_card:bool=$"../Hand".active_card!=null
	if has_card and $"../Mana".mana>0:
		self.visible=true
		var p1:Vector2=$"../Hand".active_card.global_position
		var p2:Vector2=get_viewport().get_mouse_position()
		points=PackedVector2Array([p1,p2])
	else:
		self.visible=false
