class_name BasicBullet
extends RigidBody3D

@export var damage: float = 100
@export var _speed: float = 10
@export var timeout:float = 5
@export var spin_speed: float = 5

var _source:Node3D

func set_source(source:Node3D):
	_source = source

func get_source():
	return _source

func set_speed(speed:float):
	_speed = speed

func _ready():
	angular_velocity = transform.basis.z * spin_speed
	add_to_group("bullet")
	contact_monitor = true
	max_contacts_reported = 1
	linear_velocity = transform.basis.z * _speed
	await get_tree().create_timer(timeout).timeout
	queue_free()

func _on_body_entered(body:Node):
	if body.has_method("damage"):
		body.damage(damage)
	
	if not(body is BasicBullet):
		queue_free()
