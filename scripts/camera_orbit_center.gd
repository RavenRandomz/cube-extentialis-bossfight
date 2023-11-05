extends Node3D

@export var mouse_rotation_sensitivity:float = .1 #Degrees per pixel
@export var camera_rotation_max: float = 2
@export var camera: Camera3D 


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		#Both are in degrees set to 1 degree of rotation per pixel
		var camera_rotation = event.relative * mouse_rotation_sensitivity * deg_to_rad(1)

		camera_rotation.x *= -1 #Negative because clockwise (righthand rule) is the positive direction

		print(camera_rotation)

		# Handle orbit motion 
		rotate_object_local(Vector3.UP, camera_rotation.x) 

		# Handle camera looking up and down motion
		rotate_object_local(Vector3.LEFT, camera_rotation.y)

		orthonormalize() # Prevent transform deformation due to frequent changes and floating point error

