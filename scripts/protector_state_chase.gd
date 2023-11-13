class_name ProtectorStateChase extends ProtectorState

var _target:Node3D
var _chasing_force:float = 40
var _captured_cooldown:float = 5
var _chasing_timeout:float = 10

func _ready():
	await get_tree().create_timer(_chasing_timeout).timeout
	_protector.set_state(Protector.State.ROAM)

func _integrate_forces(state):
	if (not _protector._target == null):
		var force = _protector.global_position.direction_to(_protector._target.global_position) * _chasing_force
		state.apply_force(force)
	else:
		state.linear_velocity = Vector3.ZERO
		await _protector.get_tree().create_timer(_captured_cooldown).timeout
		_protector.set_state(Protector.State.ROAM)

