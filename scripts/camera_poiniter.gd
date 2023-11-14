class_name CameraPointer extends Node3D

@export var _camera: Camera3D

const RAY_LENGTH = 1000;

func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var from = _camera.project_ray_origin(get_viewport().get_mouse_position())
	var to = from +_camera.project_ray_normal(get_viewport().get_mouse_position()) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	print(str(from) + " " + str(to))
	if (result != {}):
		print(result)

