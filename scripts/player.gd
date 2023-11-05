class_name Player
extends CharacterBody3D

@export var health: float = 1000
@export var camera: Node3D
@export var playerBody: Node3D
@export var playerCollsionMesh: Node3D
@export var playerTurnSpeed: float = 5

const SPEED = 5.0
const JUMP_VELOCITY = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func get_health() -> float:
	return health

func set_health(new_health: float) -> void:
	health = new_health
	_health_check()

func damage(damage_amount: float) -> void:
	health -= damage_amount
	_health_check()

func heal(heal_amount: float) -> void:
	health += heal_amount
	_health_check()

func kill():
	health = 0
	_health_check()

func _health_check():
	if health <= 0:
		_on_death()

func _on_death():
	pass

func _physics_process(delta):
	var translational_input= Input.get_vector("player_strafeleft", "player_straferight", "player_forward", "player_backward")

	_handle_input_logic(translational_input, delta)
	_player_view_rotation_sync(translational_input, delta)

	move_and_slide()

func _player_view_rotation_sync(translational_input, delta):
	var direction_basis = (camera.transform.basis * Vector3(translational_input.x, 0, translational_input.y)).normalized()
	var player_body_axis = playerBody.transform.basis.z
	# var direction_basis = camera.transform.basis.x

	# Relative to base node (currently the CharacterBody3D)

	var angular_difference = player_body_axis.signed_angle_to(direction_basis, transform.basis.y)
	var delta_rotation = lerp_angle(0, angular_difference, delta * playerTurnSpeed)
	if _translational_input_pressed():
		# This assumes that the y axis of the player and the camera are the same
		# Find the angle between the player and the camera
		# Use angular interpolation to figure out the set angle

		
		playerBody.rotate_object_local(Vector3.UP, delta_rotation)
		playerCollsionMesh.rotate_object_local(Vector3.UP, delta_rotation)


func _translational_input_pressed():
	return Input.is_action_pressed("player_forward")\
	or Input.is_action_pressed("player_backward")\
	or Input.is_action_pressed("player_strafeleft")\
	or Input.is_action_pressed("player_straferight")

	

	

func _handle_input_logic(translational_input, delta): 
	_handle_jump_logic(delta)
	_handle_translational_motion_logic(translational_input, delta)

func _handle_translational_motion_logic(translational_input, delta):
	var direction_basis = (camera.transform.basis * Vector3(translational_input.x, 0, translational_input.y)).normalized()
	if direction_basis:
		velocity.x = direction_basis.x * SPEED
		velocity.z = direction_basis.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func _handle_jump_logic(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
