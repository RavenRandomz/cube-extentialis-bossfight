class_name Protector extends RigidBodyEntity3D

@export var _chasing_timeout:float = 5
@export var _territory: BoxTerritory
var _chasing = false
var _target: Node3D
var _chasing_force: float = 40
var state:State = State.ROAM
var _roam_force:float = 0.5:
	get:
		return _state_roam.get_roam_force()
	set(force):
		_state_roam.set_roam_force(force)

var _rotation_force = 1;
@export var _max_rotation_speed = 10;
# States
@onready var _state_roam = ProtectorStateRoam.new(self)
@onready var _state_chase = ProtectorStateChase.new(self)
@onready var _state:ProtectorState = _state_roam

enum State {
	ROAM,
	CHASE,
	COME_BACK
}

func _integrate_forces(physics_state:PhysicsDirectBodyState3D):
	_state._integrate_forces(physics_state)
	if(physics_state.angular_velocity.length() > _max_rotation_speed):
		physics_state.angular_velocity = physics_state.angular_velocity.normalized() * _max_rotation_speed

func set_state(new_state:State):
	state = new_state
	match new_state:
		State.ROAM:
			_state = _state_roam
		State.CHASE:
			_state = _state_chase
		State.COME_BACK:
			pass
	_state._ready()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_constant_torque(transform.basis.y * _rotation_force)
	set_state(State.ROAM)

# Expects global coordinates
func is_near(point:Vector3, distance:float):
	return point.distance_to(global_position) < distance

func get_territory():
	return _territory

func _physics_process(delta):
	_state._physics_process(delta)

func _on_bullet_detected(bullet:Node3D):
	if (not state == State.CHASE):
		set_state(State.CHASE)
	_target = bullet

func _on_body_entered(body):
	if body.is_in_group("bullet"):
		_state._on_bullet_captured(body)
		_state_chase.increment_bullet_count()
		_target = null
		


