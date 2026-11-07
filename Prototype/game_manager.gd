extends Node

var is_player_turn=true
var anim_time=0.0
var max_anim_time=1.0

@export var empty_card:PackedScene
@export var upgrade:UpgradeCardCollection

var is_shop=false

func _process(delta: float) -> void:
	var map={
		"Trash":$"../Trash",
		"DECK":$"../Deck",
		"Hand":$"../Hand",
		"Shop":$"../Shop"
	}
	if not is_shop:
		$"../Shop".visible=false
		$"../Shop2".visible=false
		var current_mode_name=""
		if Input.is_key_pressed(KEY_U):
			current_mode_name="Trash"
		else:
			if Input.is_key_pressed(KEY_I):
				current_mode_name="DECK"
			else:
				current_mode_name="Hand"
		if current_mode_name!="":
				$"../Trash".visible=false
				$"../Hand".visible=false
				$"../Deck".visible=false
				$ColorRect/StateLabel.text=current_mode_name
				map[current_mode_name].visible=true
		var pos_x=0.0
		
		for c:CardNode in map[current_mode_name].get_children():
			c.position.x=pos_x
			c.position.y=0.0
			pos_x+=c.size.x+50.0
		if not is_player_turn:
			anim_time+=delta
			if anim_time>max_anim_time:
				new_turn()
				is_player_turn=true
		$POPUP.visible=not is_player_turn
	else:
		$"../Trash".visible=false
		$"../Hand".visible=false
		$"../Deck".visible=false
		$"../Shop".visible=true
		$"../Shop2".visible=true
		var pos_x=0.0
		var pos_y=0.0
		for c:CardNode in $"../Shop".get_children():
			c.position.x=pos_x
			c.position.y=pos_y
			pos_x+=c.size.x+50.0
			if c.position.x>1000.0:
				pos_x=0.0
				pos_y+=c.size.y
		if Input.is_key_pressed(KEY_R):
			end_shop()

func end_shop():
			is_shop=false
			for i in range($"../Shop".get_child_count()):
				$"../Shop".get_child(0).reparent($"../Deck")
			new_turn()

var turn_num=0
func new_turn():
	if not is_shop:
		turn_num+=1
		$"../Mana".mana=$"../Mana".max_mana
		var numer_draw=3
		if turn_num==2:
			show_shop()
			$"../Shop2".spawn(empty_card,upgrade)
			return
		for i in range(numer_draw):
			if $"../Deck".get_child_count()==0:
				shuffle()
			assert($"../Deck".get_child_count()!=0)
			print("DRAW")
			$"../Deck".get_child(0).reparent($"../Hand")

func show_shop():
	is_shop=true
	for c:Control in [$"../Deck",$"../Hand",$"../Trash"]:
		for i in range(c.get_child_count()):
			c.get_child(0).reparent($"../Shop")

func shuffle():
	var ssize=$"../Trash".get_child_count()
	for i in range(ssize):
		var cid=randi()%(ssize-i)
		print("REP")
		$"../Trash".get_child(cid).reparent($"../Deck")
	
	
func _on_end_turn_button_pressed() -> void:
	if is_player_turn:
		is_player_turn=false
		anim_time=0.0
		for c in $"../Hand".get_children():
			c.reparent($"../Trash")
	
