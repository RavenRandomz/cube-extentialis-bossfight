class_name BasicBulletSource
extends Node3D

@export var bullet_scene:PackedScene = preload("res://projectile/basic_bullet.tscn")

func fire():
	if Input.is_action_pressed("player_fire_bullet"):
		var bullet: RigidBody3D = bullet_scene.instantiate()

		bullet.global_position = global_position
		bullet.transform.basis = global_transform.basis
		get_tree().root.add_child(bullet)