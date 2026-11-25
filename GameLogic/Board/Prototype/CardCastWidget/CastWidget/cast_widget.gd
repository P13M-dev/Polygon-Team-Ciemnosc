extends CardCastWidget
class_name CastWidget
var tmp:bool=true
var active:bool=false
var cn:CardNode

class WidgetField extends WidgetResult:
	var f:FieldCollider
	func _init(f_:FieldCollider) -> void:
		f=f_

func widget_ready(_card:CardBase)->void:
	active=true
	cn=Game.hand.active_card
#when player select taget eg "move" but before move and mana payment
#result == null if cancelled:

func on_play(_card:CardBase,_result:WidgetResult)->void:
	if tmp:
		print("remove field selector")
		self.queue_free()


func _process(_delta: float) -> void:
	if active:
		$Line2D.visible=true
		var p1:Vector2=cn.global_position
		var p2:Vector2=get_viewport().get_mouse_position()
		$Line2D.points=[p1,p2]
		if Input.is_action_just_pressed("mouse_click"):
			if Game.mouse3d.current_field!=null:
				
				var fc:FieldCollider=Game.mouse3d.current_field
				active=false
				self.emit_signal("widget_input",WidgetField.new(fc))
	else:
		$Line2D.visible=false
