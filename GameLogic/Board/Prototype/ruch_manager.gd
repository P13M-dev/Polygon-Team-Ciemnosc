extends CardCastWidget
class_name RuchManager

enum MovementState {
	nieaktywny,
	select_player,
	select_field,
}

func _ready() -> void:
	Game.ruch=self

	
func widget_ready(card:CardBase)->void:
	state = MovementState.select_player
	player = null
	player_unit =null
	print("Wybieranie gracza")
	

class RuchData extends CardCastWidget.WidgetResult:
	var from:Tile
	var to:Tile
	func _init(form_:Tile,to_:Tile) -> void:
		to=to_
		from=form_

#when player select taget eg "move" but before move and mana payment
#result == null if cancelled:

func on_play(card:CardBase,result:WidgetResult)->void:
	var m:RuchData=result
	var player_unit2:Unit=m.from.unit
	m.to.unit=player_unit2
	m.from.unit=null

#signal selected_optoin(bool)
#var option:Array[Vector2i]

#func start_selecting()

#func appay(option)


var state: MovementState = MovementState.nieaktywny
var player: FieldCollider = null
var player_unit: Unit = null
signal wykonano_ruch(success: bool	)




func _process(_delta: float) -> void:
	$ColorRect.visible=false
	if state == MovementState.nieaktywny:
		return
	$ColorRect.visible=true
	if not Input.is_action_just_pressed("mouse_click"):
		return

	var clicked_field: FieldCollider = Game.mouse3d.current_field

	if clicked_field == null:
		emit_signal("wykonano_ruch",  false)
		return

	if state == MovementState.select_player:
		#if clicked_field.state != FieldCollider.FieldState.PLAYER:
		if clicked_field.get_tile().unit==null:
			print("pole bez gracza")
			state = MovementState.nieaktywny
			emit_signal("wykonano_ruch",  false)
			return

		player = clicked_field
		player_unit = player.get_tile().unit
		print("ddd")
		print(Game.ruch.name,self.name)
		print(Game.ruch.player_unit)
		print(player_unit)
		print(player_unit==Game.ruch.player_unit)
		state = MovementState.select_field
		print("gracz wybrany")
		return

	if state == MovementState.select_field:
		if clicked_field not in player.near:
			print("nie jest obok")
			state = MovementState.nieaktywny
			emit_signal("wykonano_ruch",  false)
			return

		if clicked_field.state != FieldCollider.FieldState.NONE: #cos tu nie działa
			print("skala czy cos")
			state = MovementState.nieaktywny
			emit_signal("wykonano_ruch",  false)
			return

		#player.state = FieldCollider.FieldState.NONE
		#clicked_field.state = FieldCollider.FieldState.PLAYER

		#var player_u:Unit=player.get_tile().unit
		#clicked_field.get_tile().unit=player_u
		#player.get_tile().unit=null
		emit_signal("widget_input",RuchData.new(player.get_tile(),clicked_field.get_tile()))
		player = null
		player_unit = null
		state = MovementState.nieaktywny
		#emit_signal("wykonano_ruch", true)
		
