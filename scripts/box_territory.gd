class_name BoxTerritory extends Area3D

signal watched_exited
signal watched_entered

@export var collision_shape:CollisionShape3D
@onready var shape:BoxShape3D = collision_shape.shape

var watch_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Generats a random global position within its bounds
func generate_random_internal_position() -> Vector3:
	var origin = global_position

	var offset = Vector3(randf_range(-shape.size.x, shape.size.x), 
						randf_range(-shape.size.y, shape.size.y),
						randf_range(-shape.size.z, shape.size.z))
	print(origin+offset)
	return origin + offset

func add_to_watchlist(watchee):
	watch_list.push(watchee)

func remove_from_watchlist(member):
	var member_index = watch_list.find(member)
	# -1 is the value that Array.find returns if there is no match
	if (member_index != -1):
		watch_list.remove_at(member_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
