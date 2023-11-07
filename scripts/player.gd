class_name Player
extends CharacterBodyEntity3D

@export var health: float = 1000
@export var camera: Node3D
@export var playerBody: Node3D
@export var playerCollsionMesh: Node3D
@export var playerTurnSpeed: float = 5
@export var display: Player_HUD

@export var min_health: float = 0
@export var max_health: float = 1000
@export var bullet_source: BasicBulletSource 

var player_movement_handler = PlayerMovementHandler.new(self)

var basic_bullet = preload("res://projectile/basic_bullet.tscn")
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var speed:float = 5.0:
	get:
		return player_movement_handler.speed
	set(new_speed): 
		player_movement_handler.speed = new_speed

@export var jump_speed:float = 10.0

# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	display.set_health_bar_range(min_health, max_health)
	display.update_health_bar(health)
	add_child(player_movement_handler)

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
	if not is_stunned():
		var direction_basis = (camera.transform.basis * Vector3(translational_input.x, 0, translational_input.y)).normalized()
		player_movement_handler.controlled_translational_motion(direction_basis, delta)
		_handle_bullet_firing(delta)

func _handle_bullet_firing(delta):
	if Input.is_action_pressed("player_fire_bullet"):
		bullet_source.fire()


func _handle_jump_logic(delta):
	# Handle Jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = jump_speed
