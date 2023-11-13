class_name Protector extends RigidBodyEntity3D

@export var _chasing_timeout:float = 5
@export var _territory: BoxTerritory
var _chasing = false
var _target: Node3D
var _chasing_force: float = 40
var _roam_force:float = 0.5:
	get:
		return _state_roam.get_roam_force()
	set(force):
		_state_roam.set_roam_force(force)

# States
@onready var _state_roam = ProtectorStateRoam.new(self)
@onready var _state_chase = ProtectorStateChase.new(self)
@onready var _state:ProtectorState = _state_roam

enum State {
	ROAM,
	CHASE,
	COME_BACK
}

func _integrate_forces(state:PhysicsDirectBodyState3D):
	_state._integrate_forces(state)
	pass

func set_state(state:State):
	match state:
		State.ROAM:
			_state = _state_roam
		State.CHASE:
			_state = _state_chase
		State.COME_BACK:
			pass
	_state._on_ready()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_state(State.ROAM)

# Expects global coordinates
func is_near(point:Vector3, distance:float):
	return point.distance_to(global_position) < distance

func get_territory():
	return _territory

func _physics_process(delta):
	_state._physics_process(delta)

func _on_bullet_detected(bullet:Node3D):
	set_state(State.CHASE)
	_target = bullet

func _on_body_entered(body):
	if body.is_in_group("bullet"):
		_state._on_bullet_captured(body)
		_target = null
		


