class_name PlayerMovementHandler extends Node

var _player:Player

func _init (parent_player:Player):
	_player = parent_player

func controlled_translational_motion(direction, _delta):
	var speed = _player.speed
	var velocity = direction * speed
	if direction:
		_player.velocity.x = velocity.x
		_player.velocity.z = velocity.z
	else:
		_player.velocity.x = move_toward(_player.velocity.x, 0, speed)
		_player.velocity.z = move_toward(_player.velocity.z, 0, speed)

func jump(delta):
	if not _player.is_on_floor():
		_player.velocity.y -= _player.gravity * delta