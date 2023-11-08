class_name BasicBullet
extends RigidBody3D

@export var damage: float = 100
@export var speed: float = 10
@export var timeout:float = 5

func _ready():
	add_to_group("bullet")
	contact_monitor = true
	max_contacts_reported = 1
	linear_velocity = transform.basis.z * speed
	await get_tree().create_timer(timeout).timeout
	queue_free()

func _on_body_entered(body:Node):
	if body.has_method("damage"):
		body.damage(damage)
	
	if not(body is BasicBullet):
		queue_free()
