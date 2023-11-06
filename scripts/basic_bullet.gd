extends RigidBody3D

@export var damage: float = 10
@export var speed: float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = transform.basis.z * speed
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
