class_name BasicMinion extends CharacterBodyEntity3D

enum State {
	ATTACK,
	IDLE
}

@onready var _state_attack:BasicMinionStateAttack = BasicMinionStateAttack.new(self)
@onready var _state_idle:BasicMinionStateIdle = BasicMinionStateIdle.new(self)

@onready var _state = _state_idle
@export var _gun:Gun

var DEFAULT_GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")

var _current_state = State.IDLE

func _ready():
	super._ready()

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
	_gravity_pull(delta)
	move_and_slide()

func _on_player_entered(player:Player):
	set_state(State.ATTACK)
	_state._set_target(player)


func _on_player_exited(player:Player):
	set_state(State.IDLE)

func _gravity_pull(delta):
	if not is_on_floor():
		#print("Not on floor")
		velocity.y -= DEFAULT_GRAVITY * delta

func _on_death():
	queue_free()

func damage(damage_amount:float):
	print(health)
	super.damage(damage_amount)
