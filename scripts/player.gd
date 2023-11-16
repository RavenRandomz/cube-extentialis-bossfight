class_name Player
extends CharacterBodyEntity3D

@export var camera:Node3D
@export var display:Player_HUD
@export var bullet_source:BasicBulletSource 
@export var input_handler:PlayerInputHandler
@export var body_handler:PlayerBodyHandler

var movement_handler = PlayerMovementHandler.new(self)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var speed:float = 5.0:
	get:
		return movement_handler.speed
	set(new_speed): 
		movement_handler.speed = new_speed

@export var jump_speed:float = 10.0:
	get:
		return movement_handler.jump_speed
	set(new_jump_speed):
		movement_handler.jump_speed = new_jump_speed

@export var body_turn_speed:float = 10.0:
	get:
		return body_handler.body_turn_speed
	set(new_body_turn_speed):
		body_handler.body_turn_speed = new_body_turn_speed



func _ready():
	super._ready()
	display.set_health_bar_range(min_health, max_health)
	display.update_health_bar(health)
	add_child(movement_handler)

func damage(damage_amount:float):
	super.damage(damage_amount)
	display.update_health_bar(health)

func _physics_process(_delta):
	move_and_slide()

func _on_player_bullet_fire():
	if (not is_stunned()):
		bullet_source.fire()

func _on_player_jump_input():
	if (not is_stunned()):
		movement_handler.jump()

func _on_translational_motion_input(translational_input_map):
	if (not is_stunned()):
		var direction = (camera.transform.basis * Vector3(translational_input_map.x, 0, translational_input_map.y)).normalized()
		movement_handler.controlled_translational_motion(direction)

func get_desired_translational_movement_direction():
	var raw_translational_map = input_handler.get_translational_input_map()
	return (camera.transform.basis * Vector3(raw_translational_map.x, 0, raw_translational_map.y)).normalized()
