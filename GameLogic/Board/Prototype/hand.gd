extends Control

class_name  Hand

var active_card:CardNode=null
@export var mouse:Mouse3D
@export var library:WidgetLibrary

func _ready() -> void:
	var ruch_manager: RuchManager = get_parent().get_node("RuchManager")
	ruch_manager.wykonano_ruch.connect(_czy_ruch)
	Game.hand=self
	
	
func _czy_ruch(success: bool) -> void:#karta ruchu przesuwa gracza, to co jest do zrobienia z kartą zostawiam
	if success == true:
		print("udalo sie")
	else:
		print("nie udalo sie")

@export var rm:RuchManager

var current_widgets:Array[CardCastWidget]=[]
var current_widget_id:int=-2
var current_widget:CardCastWidget=null
var wRes:Array[CardCastWidget.WidgetResult]=[]

func _process(_delta: float) -> void:
	if current_widgets.size()==0:
		if Input.is_action_just_pressed("mouse_click"):
			for c:CardNode in self.get_children():
				if c.get_global_rect().has_point(c.get_global_mouse_position()):
					var cb:CardBase=c.card
					current_widgets=cb.get_widget(library)
					current_widget_id=-1
					active_card=c
					wRes=[]
	else:
		assert(active_card!=null)
		if current_widget==null:
			print("NEXT")
			current_widget_id+=1
			
			if current_widget_id<current_widgets.size():
				current_widget=current_widgets[current_widget_id]
				current_widget.widget_ready(active_card.card)
				current_widget.widget_input.connect(func(r:CardCastWidget.WidgetResult)->void:
						print("EEEE")
						self.wRes.append(r)
						self.current_widget=null
						)
			else:
				print("TRY CASTING")
				for w in wRes:
					if w is MenuWidget.WidgetString:
						print(w.vaule)
					else:
						if w is CastWidget.WidgetField:
							var tile:Tile=w.f.get_tile()
							print("Tile(",tile.board_position_x," ",tile.board_position_y,")")
						else:
							print(w)
				print("####")
				if $"../Mana".mana>1:
							print("cast")
							for wid in range(current_widgets.size()):
								current_widgets[wid].on_play(active_card.card,wRes[wid])
							#Call the card
							#card.
							active_card.card.cast(wRes)
							if not active_card.card.exile:
								active_card.reparent($"../Trash")
							else:
								active_card.reparent($"../Exile")
							$"../Mana".mana-=1
							active_card=null
							current_widgets=[]
				
func _process2(_delta: float) -> void:
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
