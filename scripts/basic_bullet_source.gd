class_name BasicBulletSource
extends Node3D

@export var bullet_scene:PackedScene = preload("res://projectile/basic_bullet.tscn")
@export var _cool_down:float = 0.1
@export var _blame_node: Node3D # Who to blame for the firing of the bullet
var _firing:bool = false
var _continuous_fire:bool = false



func fire():
	if (not _firing):
		var bullet: BasicBullet = bullet_scene.instantiate()
		_firing = true
		bullet.set_source(_blame_node)
		bullet.global_position = global_position
		bullet.transform.basis = global_transform.basis
		get_tree().root.add_child(bullet)
		await get_tree().create_timer(_cool_down).timeout
		_firing = false

func start_continuous_fire():
	_continuous_fire = true

func stop_continous_fire():
	_continuous_fire = false

func _physics_process(delta):
	_continuous_fire_logic()

func _continuous_fire_logic():
	if (_continuous_fire):
		fire()

func set_cooldown(cool_down:float):
	_cool_down = cool_down

func get_cooldown() -> float:
	return _cool_down
