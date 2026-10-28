extends Node
class_name Mouse3D
@export var cam:Camera3D
@export var cam2d:Camera2D
@export var ray:RayCast3D
@export var is_2D:bool=false
var current_field=null

func _process(delta: float) -> void:
	if is_2D:
		var gc=cam2d.get_screen_center_position()
		var mouse=get_viewport().get_mouse_position()-get_viewport().size*0.5
		$ColisonPoint.global_position=gc+mouse
		if current_field!=null:
			current_field.is_hover=false
		if $ColisonPoint.has_overlapping_areas():
			var collider=$ColisonPoint.get_overlapping_areas()[0]
			if collider is Field2D:
				print(collider.name)
				collider.is_hover=true
				current_field=collider
	else:
		var ogr=cam.project_ray_origin(get_viewport().get_mouse_position())
		var no=cam.project_ray_normal(get_viewport().get_mouse_position())
		
		ray.global_transform=Transform3D.IDENTITY.translated(ogr)
		ray.target_position=no*100.0
		ray.force_raycast_update()
		if current_field!=null:
			current_field.is_hover=false
		if ray.is_colliding():
			var collider:CollisionObject3D=ray.get_collider()
			if collider is Field:
				collider.is_hover=true
				current_field=collider
