class_name ProtectorStateRoam extends ProtectorState

var _roam_checkpoint: Vector3
var _checkpoint_change_threshold: float = 1# How close the protector is to trigger a checkpoint change
var _roam_force: float = 1
var _max_speed: float = 5

func _init(protector:Protector):	
	_protector = protector

func _on_ready():
	print(_roam_checkpoint)
	_new_roam_checkpoint()


func _physics_process(_delta):
	var direction_to_checkpoint = _protector.get_global_position().direction_to(_roam_checkpoint)
	_protector.apply_impulse(direction_to_checkpoint * _roam_force)


	if (_protector.is_near(_roam_checkpoint, _checkpoint_change_threshold)):
		_new_roam_checkpoint()


# Called from protector
func _integrate_forces(state:PhysicsDirectBodyState3D):
	print(state.linear_velocity)
	if (state.linear_velocity.length() > _max_speed):
		state.linear_velocity.x = clamp(state.linear_velocity.x, 0, _max_speed)
		state.linear_velocity.y = clamp(state.linear_velocity.y, 0, _max_speed)
		state.linear_velocity.z = clamp(state.linear_velocity.z, 0, _max_speed)


func _new_roam_checkpoint():
		# Set the new checkpoint to a random point within the territory that Protector Occupies
	_roam_checkpoint = _protector.get_territory().generate_random_internal_position()

func set_roam_force(force:float) -> void:
	_roam_force = force

func get_roam_force() -> float:
	return _roam_force
