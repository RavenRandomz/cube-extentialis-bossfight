class_name BasicMinionStateAttack extends BasicMinionState

var _target:Node3D
var speed = 1

func _set_target(node:Node3D):
	_target = node

func _controlled_translational_motion(direction):
	var velocity = direction * speed
	if direction:
		_basic_minion.velocity.x = velocity.x
		_basic_minion.velocity.z = velocity.z
	else:
		_basic_minion.velocity.x = move_toward(_basic_minion.velocity.x, 0, speed)
		_basic_minion.velocity.z = move_toward(_basic_minion.velocity.z, 0, speed)
	

func _physics_process(delta):
	if (_target != null):
		var _target_direction = _basic_minion.global_position.direction_to(_target.global_position)
		_controlled_translational_motion(_target_direction)
