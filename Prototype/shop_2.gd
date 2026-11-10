extends Control

func spawn(emp:PackedScene,up:UpgradeCardCollection):
	print("SPAWNING.....")
	var pos_x=0.0
	for card:CardBase in up.posibilities:
		print("$$$")
		var card_instance:CardNode=emp.instantiate()
		card_instance.card=card
		self.add_child(card_instance)
		card_instance.position.x=pos_x
		pos_x+=card_instance.size.x+50

func _process(delta: float) -> void:
	for card in self.get_children():
		if card.get_global_rect().has_point(card.get_global_mouse_position()):
			card.color=Color.YELLOW
			if Input.is_action_just_pressed("mouse_click"):
				card.reparent($"../Hand")
				for c in self.get_children():
					c.queue_free()
				$"../GameManager".end_shop()
		else:
			card.color=Color.BLACK
