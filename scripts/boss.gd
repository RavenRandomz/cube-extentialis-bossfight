extends AnimatableBody3D

@export var display: BossFightHUD

@export var health: float = 100000

@export var min_health: float = 0
@export var max_health: float = 100000

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
	display.update_health_bar(health)
	if health <= 0:
		_on_death()

func _on_death():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	display.set_health_bar_range(min_health, max_health)
	display.update_health_bar(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
