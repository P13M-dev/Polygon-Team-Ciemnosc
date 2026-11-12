extends Control

class_name  Hand

var active_card:CardNode=null
@export var mouse:Mouse3D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_click"):
		var pos:Vector2=get_viewport().get_mouse_position()
		var last_active_card:CardNode=active_card
		active_card=null
		for c:CardNode in self.get_children():
			print(c.global_position," ",pos)
			#if c.global_position.distance_to(pos)<100.0:
			if c.get_global_rect().has_point(c.get_global_mouse_position()):
				active_card=c
				print(c.efect)
		if active_card==null:
			if $"../Mana".mana>0:
				if last_active_card!=null:
					if mouse.current_field!=null:
						print("USE")
						if last_active_card.card!=null:
							last_active_card.card.cast_on(mouse.current_field)
						if not last_active_card.card.exile:
							last_active_card.reparent($"../Trash")
						else:
							last_active_card.reparent($"../Exile")
						$"../Mana".mana-=1
