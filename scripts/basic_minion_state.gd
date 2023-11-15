class_name  BasicMinionState extends CharacterBodyEntity3D

var _basic_minion:BasicMinion

func _init(basic_minion):
	_basic_minion = basic_minion

func _set_target(target:Node3D):
	pass

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