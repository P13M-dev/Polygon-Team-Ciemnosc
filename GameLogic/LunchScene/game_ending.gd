extends Node
var time=0.0

func _process(delta: float) -> void:
	if  (not $"../BoardManager".is_enemy_life) or (not $"../BoardManager".is_player_life):
		print("DDDDD")
		time+=delta
		if time>0.3:
			if not $"../BoardManager".is_enemy_life:
				$"../GameWIN".visible=true
			if not $"../BoardManager".is_player_life:
				$"../GameOVER".visible=true
		if time>1.5:
			get_tree().reload_current_scene()
