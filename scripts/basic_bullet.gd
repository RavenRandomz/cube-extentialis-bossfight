class_name BasicBullet
extends RigidBody3D

@export var damage: float = 100
@export var speed: float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize collision detect
	contact_monitor = true
	max_contacts_reported = 1

	linear_velocity = transform.basis.x * speed

func _on_body_entered(body:Node):
	if body.has_method("damage"):
		body.damage(damage)
	
	if not(body is BasicBullet):
		queue_free()
	
