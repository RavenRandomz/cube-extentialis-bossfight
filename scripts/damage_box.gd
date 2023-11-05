extends StaticBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_3d_body_shape_entered(body_rid:RID, body:Node3D, body_shape_index:int, local_shape_index:int):
	print(str(body) + "Touched me")
