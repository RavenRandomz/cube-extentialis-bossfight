class_name Player
extends CharacterBody3D

@export var camera: Node3D
@export var playerBody: Node3D

const SPEED = 5.0
const JUMP_VELOCITY = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")





func _physics_process(delta):
	_handle_input_logic(delta)

	move_and_slide()


func _handle_input_logic(delta): 
	_handle_jump_logic(delta)
	_handle_translational_motion_logic(delta)

func _handle_translational_motion_logic(delta):
	var input_dir = Input.get_vector("player_strafeleft", "player_straferight", "player_forward", "player_backward")
	var direction_basis = (camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
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
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
