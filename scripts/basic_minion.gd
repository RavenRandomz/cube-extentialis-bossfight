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

func _physics_process(delta):
	_state._physics_process(delta)
	move_and_slide()

func _on_player_entered(player:Player):
	set_state(State.ATTACK)
	_state._set_target(player)


func _on_player_exited(player:Player):
	set_state(State.IDLE)
