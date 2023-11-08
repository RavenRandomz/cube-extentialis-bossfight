extends Area3D

signal bullet_entered(bullet:Node3D)

func _on_body_entered(body:Node3D):
	print("Entry")
	if (body.is_in_group("bullet")):
		bullet_entered.emit(body)
