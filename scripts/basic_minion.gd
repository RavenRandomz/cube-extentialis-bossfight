class_name BasicMinion extends CharacterBodyEntity3D

enum State {
	ATTACK,
	IDLE
}

@onready var _state_attack:BasicMinionStateAttack = BasicMinionStateAttack.new(self)
@onready var _state_idle:BasicMinionStateIdle = BasicMinionStateIdle.new(self)

@onready var _state = _state_idle

var _current_state = State.IDLE

func set_state(state:State):
	match (state):
		State.ATTACK:
			_state = _state_attack
			_current_state = State.ATTACK
		State.IDLE:
			_state = _state_idle
			_current_state = State.IDLE	
	_state._ready()

func _on_player_entered(player:Player):

	print(str(player) + "Entered")


func _on_player_exited(player:Player):
	print(str(player) + "Exited")
	pass # Replace with function body.
