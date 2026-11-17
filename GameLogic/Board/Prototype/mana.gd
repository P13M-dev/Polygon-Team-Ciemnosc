extends ColorRect

var mana:int=4
var max_mana:int=4

func _physics_process(_delta: float) -> void:
	$Label.text=str(mana)+"/"+str(max_mana)
