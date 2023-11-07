class_name PlayerBodyHandler extends Node

@export var _player:Player
@export var _player_collision_shape:CollisionShape3D
@export var input_handler:PlayerInputHandler

var body_turn_speed = 10

func _ready():
	print("I am here")

func _process(delta):
	print("Active")
	_player_view_rotation_sync(delta)

func _player_view_rotation_sync(delta):
	var direction = _player.get_desired_translational_movement_direction()
	var player_forward_body_axis = _player_collision_shape.transform.basis.z

	# Relative to base node (currently the player)
	# This assumes that the y axis of the player and the camera are the same
	# Find the angle between the player and the camera
	# Use angular interpolation to figure out the amount to rotate
	# The ideal case is that the angle is 0 (since the direction that the player is moving towards
	# is the angular "origin", the 0 degrees). That means that the rotation of the player body is equal
	# To the origin if the angle is 0 degrees
	var angular_difference = player_forward_body_axis.signed_angle_to(direction, _player_collision_shape.transform.basis.y)
	print(angular_difference)
	var delta_rotation = lerp_angle(0, angular_difference, delta * body_turn_speed)

	if input_handler._translational_input_active():
		_rotate_bodies(delta_rotation)

func _rotate_bodies(delta_rotation):
		_player_collision_shape.rotate_object_local(Vector3.UP, delta_rotation)


