class_name CameraPointer extends Node3D

@export var _camera: Camera3D
@export var _ray_buffer = 10

const RAY_LENGTH = 1000;

func _camera_is_looking_at():
	var space_state = get_world_3d().direct_space_state
	var from = _camera.project_ray_origin(get_viewport().get_mouse_position())
	var real_from = from +_camera.project_ray_normal(get_viewport().get_mouse_position()) * _ray_buffer

	var to = real_from +_camera.project_ray_normal(get_viewport().get_mouse_position()) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	return result

func _physics_process(_delta):
	var target = _camera_is_looking_at()
	if (target != {}):
		look_at(target["position"])
	else:
		var to = _camera.project_ray_normal(get_viewport().get_mouse_position()) * RAY_LENGTH
		look_at(to)
