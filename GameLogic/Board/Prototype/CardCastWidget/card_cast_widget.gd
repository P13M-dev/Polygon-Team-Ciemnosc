@abstract
extends Node
class_name CardCastWidget



class WidgetResult:
	pass


@abstract
func widget_ready(card:CardBase)->void

#when player select taget eg "move" but before move and mana payment
#result == null if cancelled
@warning_ignore("unused_signal")
signal widget_input(result:WidgetResult)


#when player already pay for card
@abstract
func on_play(card:CardBase,result:WidgetResult)->void
