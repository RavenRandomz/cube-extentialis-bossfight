class_name Entity

# It is possible to simply define Entity as an extension of Node
# However, that would mean that the Entity would have a "Body" (in this case
# being the CharacterBody3D. Scene tree wise, this would lead to a static
# location (probably at 0,0,0) while the "body" moves around
# Currently, this is deemed to be too cumbersome so because of the small
# amount of PhysicsBody3D classes that all entities are based off of
# For the time being, multiple inheritance is being simulated by adapters
# So the player class and any enemy can inherit the basic funcitonalities of
# Health and being stunned (reducing the need for boilerplate code).
# Perhaps later, all of these redundant classes will be changed at the cost of
# Sacrificing compatability with Godot's framework of nodes
# (A parent Entity that inherits Node3D would mean that the player body is in the Node3D)
# That is on the scene tree. So if the player has to be moved around, the Node3D parent would have to be changed.
# Or that node would ismply be "disembodied" while the body is transferred to moving platforms and whatnot.



@export var max_health = 1000
@export var min_health = 0
var health = 1000
var stunned = false

func _init(starting_health:float = 1000):
	health = starting_health
	

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

