class_name Protector extends RigidBodyEntity3D

@export var _chasing_timeout:float = 5
@export var _territory: BoxTerritory
var _chasing = false
var _target: Node3D
var _chasing_force: float = 40
var _roam_force:float = 40:
	get:
		return _state_roam.get_roam_force()
	set(force):
		_state_roam.set_roam_force(force)

# States
var _state:ProtectorState = _state_roam
var _state_roam = ProtectorStateRoam.new(self, _roam_force)

enum State {
	ROAM,
	CHASE,
	COME_BACK
}

func set_state(state:State):
	match state:
		State.ROAM:
			_state = _state_roam
		State.CHASE:
			pass
		State.COME_BACK:
			pass

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

# Expects global coordinates
func is_near(point:Vector3, distance:float):
	return point.distance_to(global_position) < distance

func get_territory():
	return _territory

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_state._physics_process(delta)

func _old_physics_process(_delta):
	if (not _target == null):
		var force = _get_direction_to_target() * _chasing_force
		apply_central_force(force)
	else:
		_stop_motion()


func _get_direction_to_target():
	var positional_difference_vector =  _target.global_position - global_position
	var direction = positional_difference_vector.normalized()
	return direction

func _on_bullet_detected(bullet:Node3D):
	if (not _chasing):
		_target = bullet
		_chasing = true
		await get_tree().create_timer(_chasing_timeout).timeout
		_stop_chase()

func _stop_chase():
		_chasing = false
		_target = null
		_stop_motion()

func _stop_motion():
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO

func _on_body_entered(body):
	if body.is_in_group("bullet"):
		body.queue_free()
		_stop_chase()


