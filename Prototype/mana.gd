extends ColorRect

var mana:int=2
var max_mana:int=2

func _physics_process(delta: float) -> void:
	$Label.text=str(mana)+"/"+str(max_mana)
