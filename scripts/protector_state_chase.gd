class_name ProtectorStateChase extends ProtectorState

var _target:Node3D
var _chasing_force:float = 40
var _captured_cooldown:float = 1
var _chasing_timeout:float = 2
var _bullet_count:int = 0
var _bullet_chain_max = 10

func _ready():
	reset_bullet_count()
	await _protector.get_tree().create_timer(_chasing_timeout).timeout
	_protector.set_state(Protector.State.ROAM)
	

func _integrate_forces(state):
	if (not _protector._target == null):
		var force = _protector.global_position.direction_to(_protector._target.global_position) * _chasing_force
		state.apply_force(force)
	else:
		state.linear_velocity = Vector3.ZERO
		if (_bullet_count >= _bullet_chain_max):
			await _protector.get_tree().create_timer(_captured_cooldown).timeout
			_protector.set_state(Protector.State.ROAM)


func increment_bullet_count():
	print(_bullet_count)
	_bullet_count += 1

func reset_bullet_count():
	_bullet_count = 0
