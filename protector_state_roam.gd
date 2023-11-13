class_name ProtectorStateRoam extends ProtectorState

var _roam_checkpoint: Vector3
var _checkpoint_change_threshold: float = 1# How close the protector is to trigger a checkpoint change
var _roam_force: float = 20

func _init(protector:Protector, roam_force:float):	
	_protector = protector
	_roam_force = roam_force

func _physics_process(_delta):
	var direction_to_checkpoint = _protector.get_global_position().direction_to(_roam_checkpoint)
	_protector.apply_impulse(direction_to_checkpoint * _roam_force)

	if (_protector.is_near(_roam_checkpoint, _checkpoint_change_threshold)):
		# Set the new checkpoint to a random point within the territory that Protector Occupies
		_roam_checkpoint = _protector.get_territory().generate_random_internal_position()