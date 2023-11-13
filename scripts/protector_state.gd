class_name ProtectorState extends RigidBodyEntity3D

var _protector: Protector

func _init(prot:Protector):
	_protector = prot

func _on_ready():
	pass

func _physics_process(_delta):
	pass

func _integrate_forces(_state):
	pass

func _process(_delta):
	pass

func _on_bullet_captured(_bullet:Node3D):
	pass