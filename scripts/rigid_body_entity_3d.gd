class_name RigidBodyEntity3D extends RigidBody3D

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

@export var health:float = 1000:
	get:
		return _entity.get_health()
	set(new_health): 
		_entity.set_health(new_health)

@export var min_health:float = 1000:
	get:
		return _entity.min_health
	set(new_min_health): 
		_entity.min_health = new_min_health

@export var max_health:float = 1000:
	get:
		return _entity.min_health
	set(new_max_health): 
		_entity.min_health = new_max_health

var _entity = Entity.new(get_tree())

signal on_died

func _ready():
	add_child(_entity)
	_entity.on_death.connect(_on_death)

# Boilerplate functions
func get_health() -> float:
	return _entity.health

func set_health(new_health: float) -> void:
	_entity.health = new_health
	_entity._health_check()

func damage(damage_amount: float) -> void:
	_entity.health -= damage_amount
	_entity._health_check()

func heal(heal_amount: float) -> void:
	_entity.health += heal_amount
	_entity._health_check()

func kill():
	_entity.health = 0
	_entity._health_check()

func is_stunned():
	return _entity.stunned

func stun(stun_time):
	_entity.stun(stun_time)

func _on_death():
	on_died.emit()
