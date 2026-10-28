extends Control

class_name  Hand

var active_card:CardNode=null
@export var mouse:Mouse3D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_click"):
		var pos=get_viewport().get_mouse_position()
		var last_active_card=active_card
		active_card=null
		for c:CardNode in self.get_children():
			print(c.global_position," ",pos)
			if c.global_position.distance_to(pos)<100.0:
				active_card=c
				print(c.efect)
		if active_card==null:
			if last_active_card!=null:
				if mouse.current_field!=null:
					if last_active_card.efect=="fire":
						mouse.current_field.state=Field.FieldState.FIRE
						for f in mouse.current_field.near:
							f.state=Field.FieldState.FIRE
					if last_active_card.efect=="water":
						mouse.current_field.state=Field.FieldState.WATER
						for f in mouse.current_field.near:
							f.state=Field.FieldState.WATER
					last_active_card.queue_free()
					
