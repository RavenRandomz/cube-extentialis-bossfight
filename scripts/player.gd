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

@export var jump_speed:float = 10.0:
	get:
		return player_movement_handler.jump_speed
	set(new_jump_speed):
		player_movement_handler.jump_speed = new_jump_speed


# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	super._ready()
	display.set_health_bar_range(min_health, max_health)
	display.update_health_bar(health)
	add_child(player_movement_handler)

func _physics_process(delta):
	# _player_view_rotation_sync(get_desired_movement_direction(), delta)
	move_and_slide()


func _translational_input_pressed():
	return Input.is_action_pressed("player_forward")\
	or Input.is_action_pressed("player_backward")\
	or Input.is_action_pressed("player_strafeleft")\
	or Input.is_action_pressed("player_straferight")


func _on_player_bullet_fire():
	if (not is_stunned()):
		bullet_source.fire()

func _on_player_jump_input():
	if (not is_stunned()):
		player_movement_handler.jump()

func _on_translational_motion_input(translational_input_map):
	if (not is_stunned()):
		var direction = (camera.transform.basis * Vector3(translational_input_map.x, 0, translational_input_map.y)).normalized()
		player_movement_handler.controlled_translational_motion(direction)

func get_desired_movement_direction():
	var raw_translational_map = player_movement_handler.get_translational_input_map()
	return (camera.transform.basis * Vector3(raw_translational_map.x, 0, raw_translational_map.y)).normalized()
