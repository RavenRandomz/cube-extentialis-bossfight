class_name Entity

var health = 1000
var stunned = false

func get_health() -> float:
	return health

func set_health(new_health: float) -> void:
	health = new_health
	_health_check()

func damage(damage_amount: float) -> void:
	health -= damage_amount
	_health_check()

func heal(heal_amount: float) -> void:
	health += heal_amount
	_health_check()

func kill():
	health = 0
	_health_check()

func _health_check():
	if health <= 0:
		_on_death()

func _on_death():
	pass

# Stun time in seconds
func stun(stun_time):
	if not stunned:
		stunned = true
		var timer = Timer.new()
		timer.start(stun_time)
		await timer.timeout
		stunned = false

