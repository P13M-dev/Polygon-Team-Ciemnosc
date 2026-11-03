extends Node

var is_player_turn=true
var anim_time=0.0
var max_anim_time=1.0

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_U):
		$"../Trash".visible=true
		$"../Hand".visible=false
		$"../Deck".visible=false
		$ColorRect/StateLabel.text="Trash"
	else:
		if Input.is_key_pressed(KEY_I):
			$"../Trash".visible=false
			$"../Hand".visible=false
			$"../Deck".visible=true
			$ColorRect/StateLabel.text="DECK"
		else:
			$"../Trash".visible=false
			$"../Hand".visible=true
			$"../Deck".visible=false
			$ColorRect/StateLabel.text="Hand"
	if not is_player_turn:
		anim_time+=delta
		if anim_time>max_anim_time:
			new_turn()
			is_player_turn=true
	$POPUP.visible=not is_player_turn

func new_turn():
	$"../Mana".mana=$"../Mana".max_mana
	var numer_draw=3
	for i in range(numer_draw):
		if $"../Deck".get_child_count()==0:
			shuffle()
		assert($"../Deck".get_child_count()!=0)
		print("DRAW")
		$"../Deck".get_child(0).reparent($"../Hand")

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
	
