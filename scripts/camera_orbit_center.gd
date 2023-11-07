extends Node3D

@export var mouse_rotation_sensitivity:float = .1  #Degrees per pixel
@export var camera_rotation_max: float = 2
@export var vertical_pivot: Node3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		var camera_rotation = event.relative * mouse_rotation_sensitivity * deg_to_rad(1)

		# Handle camera looking up and down motion
		vertical_pivot.rotate_object_local(Vector3.LEFT, camera_rotation.y)

		# By mathematical convension,
		# Clockwise is the positive direciton, which means positive is to the left.
		# If the axis is upwards (by the right hand rule)
		# But for a vector downwards, turning to the right is positive
		rotate_object_local(Vector3.DOWN, camera_rotation.x) 
		# Orbit motion handling
		orthonormalize() # Prevent transform deformation due to frequent changes and floating point error

