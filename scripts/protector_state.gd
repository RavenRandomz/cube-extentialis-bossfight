class_name ProtectorState extends RigidBodyEntity3D

var _protector: Protector

func _init(prot:Protector):
	_protector = prot

func _integrate_forces(state):
	pass

func _process(delta):
	pass