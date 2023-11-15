class_name PlayerDetector extends Area3D

signal player_entered(player:Player)
signal player_exited(player:Player)

func _on_body_entered(body:Node3D):
	if (body is Player):
		player_entered.emit(body)


func _on_body_exited(body:Node3D):
	if (body is Player):
		player_exited.emit(body)