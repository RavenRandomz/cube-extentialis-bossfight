class_name BasicMinion extends CharacterBodyEntity3D

enum State {
	ATTACK,
	IDLE
}

@onready var _state_attack:BasicMinionStateAttack = BasicMinionStateAttack.new(self)
@onready var _state_idle:BasicMinionStateIdle = BasicMinionStateIdle.new(self)


func _on_player_entered(player:Player):

	print(str(player) + "Entered")


func _on_player_exited(player:Player):
	print(str(player) + "Exited")
	pass # Replace with function body.
