class_name Gun extends Node3D

@export var _bullet_source:BasicBulletSource

func aim(target:Node3D):
	look_at(target.global_position)

func fire():
	_bullet_source.fire()
