class_name BasicSpammer extends RigidBodyEntity3D 

@export var _bullet_sources:Array[BasicBulletSource] = []

@onready var _bullet_source_manager = BulletSourceManager.new(_bullet_sources)

var _current_rotation_axis = transform.basis.z
@export var rotation_speed:float = 0.5
@export var _rotation_axis_rotation_speed = 0.5

func _ready():
	_bullet_source_manager.start_continous_fire_all()
	add_to_group("enemy")

func _physics_process(delta):
	angular_velocity = _current_rotation_axis * rotation_speed
	_current_rotation_axis = _current_rotation_axis.rotated(transform.basis.y, _rotation_axis_rotation_speed)
	print(_current_rotation_axis)
