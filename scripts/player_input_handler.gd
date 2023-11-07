class_name PlayerInputHandler
extends Node

signal on_translational_motion_input(translational_input_map:Vector3)
signal on_player_jump_input
signal on_player_bullet_fire

func get_translational_input_map():
	return Input.get_vector("player_strafeleft", "player_straferight", "player_forward", "player_backward")

func _process(_delta):
	_report_inputs()

func _report_inputs(): 
	if _translational_input_active():
		on_translational_motion_input.emit(get_translational_input_map())
	else:
		on_translational_motion_input.emit(Vector2.ZERO)

	if _jump_input_active():
		on_player_jump_input.emit()
	
	if _fire_bullet_input_active():
		on_player_bullet_fire.emit()


func _translational_input_active():
	return Input.is_action_pressed("player_forward")\
	or Input.is_action_pressed("player_backward")\
	or Input.is_action_pressed("player_strafeleft")\
	or Input.is_action_pressed("player_straferight")

func _jump_input_active():
	return Input.is_action_just_pressed("player_jump")

func _fire_bullet_input_active():
	return Input.is_action_pressed("player_fire_bullet")