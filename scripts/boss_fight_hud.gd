class_name BossFightHUD
extends Control

@export var health_bar: ProgressBar
@export var health: float = 10000

func update_health_bar(health):
	health_bar.value = health

func set_health_bar_range(min_val, max_val):
	health_bar.min_value = min_val
	health_bar.max_value = max_val

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
