class_name BasicBulletSource
extends Node3D

@export var bullet_scene:PackedScene = preload("res://projectile/basic_bullet.tscn")
@export var _cool_down:float = 0.1
var _firing:bool = false


func fire():
	var bullet: RigidBody3D = bullet_scene.instantiate()
	if (not _firing):
		_firing = true
		bullet.global_position = global_position
		bullet.transform.basis = global_transform.basis
		get_tree().root.add_child(bullet)
		await get_tree().create_timer(_cool_down).timeout
		_firing = false


func set_cooldown(cool_down:float):
	_cool_down = cool_down

func get_cooldown() -> float:
	return _cool_down