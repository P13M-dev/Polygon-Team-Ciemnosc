@abstract
extends Resource

class_name CardBase
@export var name:String
@export var exile:bool=false
@export var description:String

class WidetResult:
	pass

class CastResult extends WidetResult:
	var ok:bool

class CastWidget:
	var callback:Callable
	var mouse:Mouse3D
	var debug_line:Line2D
	func _ready()->void:
		pass
		
	func _process(_delta: float) -> void:
		pass
		
class SecelectFieldWidget extends  CastWidget:
	func _process(_delta: float) -> void:
		pass

@abstract
func get_widget() -> CastWidget

@abstract
func cast_on(f:FieldCollider) -> void
