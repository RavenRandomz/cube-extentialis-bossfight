extends Area3D

signal bullet_entered(bullet:Node3D)

@export var validator: Script
@onready var _validator = validator.new()


func _on_body_entered(body:Node3D):
	if (_validator.validate(body)):
		bullet_entered.emit(body)
