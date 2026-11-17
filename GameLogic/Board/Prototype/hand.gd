extends Control

class_name  Hand

var active_card:CardNode=null
@export var mouse:Mouse3D

func _ready() -> void:
	var ruch_manager: RuchManager = get_parent().get_node("RuchManager")
	ruch_manager.wykonano_ruch.connect(_czy_ruch)

func _czy_ruch(success: bool) -> void:#karta ruchu przesuwa gracza, to co jest do zrobienia z kartą zostawiam
	if success == true:
		print("udalo sie")
	else:
		print("nie udalo sie")

@export var rm:RuchManager

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_click"):
		if (true) if active_card==null else (not active_card.card is MovementCard):
			var pos:Vector2=get_viewport().get_mouse_position()
			var last_active_card:CardNode=active_card
			active_card=null
			for c:CardNode in self.get_children():
				print(c.global_position," ",pos)
				#if c.global_position.distance_to(pos)<100.0:
				if c.get_global_rect().has_point(c.get_global_mouse_position()):
					active_card=c
					if active_card.card is MovementCard:#dodałem to
						var ruch_manager: RuchManager = get_parent().get_node("RuchManager")
						ruch_manager.activate()
						#active_card = null
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
	else:
		if active_card!=null:
			if active_card.card is MovementCard:
				if rm.state==RuchManager.MovementState.nieaktywny:
								print("USE")
								if active_card.card!=null:
									active_card.card.cast_on(mouse.current_field)
								if not active_card.card.exile:
									active_card.reparent($"../Trash")
								else:
									active_card.reparent($"../Exile")
								$"../Mana".mana-=1
								active_card=null
