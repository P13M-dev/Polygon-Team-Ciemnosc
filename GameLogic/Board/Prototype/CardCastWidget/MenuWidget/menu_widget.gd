extends CardCastWidget
class_name MenuWidget

var tmp:bool=true
@export var option:Array[String] 

@export var option_b:Array[Button] 
@export var ok_button:Button
@export var cancel_button:Button

class WidgetString extends WidgetResult:
	var vaule:String
	func _init(v:String) -> void:
		vaule=v

func _ready() -> void:
	$".".visible=false

var choise_id:int=-1

func widget_ready(_card:CardBase)->void:
	$".".visible=true
	assert(option_b.size()==option.size())
	for bid in range(option_b.size()):
		var b:Button=option_b[bid]
		b.text=option[bid]
		var c:Callable=func ()->void:
			self.choise_id=bid
			for b2 in option_b:
				b2.visible=false
			$ColorRect/Label.text=option_b[choise_id].text
		b.pressed.connect(c)
	var on_ok:Callable=func ()->void:
		if choise_id==-1:
			$ColorRect.visible=false
			self.emit_signal("widget_input",null)
		else:
			$ColorRect.visible=false
			self.emit_signal("widget_input",WidgetString.new(option_b[choise_id].text))
	var on_cancel:Callable=func ()->void:
		self.emit_signal("widget_input",null)
	ok_button.pressed.connect(on_ok)
	cancel_button.pressed.connect(on_cancel)

func on_play(_card:CardBase,_result:WidgetResult)->void:
	if tmp:
		print("remove move selector")
		self.queue_free()
