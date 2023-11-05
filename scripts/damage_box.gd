extends StaticBody3D

@export var damage: float = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_3d_body_shape_entered(body_rid:RID, body:Node3D, body_shape_index:int, local_shape_index:int):
	if (body.has_method("damage")):
		body.damage(damage)