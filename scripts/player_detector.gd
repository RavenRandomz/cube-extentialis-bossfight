class_name PlayerDetector extends Area3D

signal player_entered
signal player_exited

func _on_body_entered(body:Node3D):
	if (body is Player):
		player_entered.emit()


func _on_body_exited(body:Node3D):
	if (body is Player):
		player_exited.emit()
