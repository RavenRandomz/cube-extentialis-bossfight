class_name Player_HUD
extends Control

@export var health_bar: ProgressBar

func update_health_bar(health:float):
	health_bar.value = health

func set_health_bar_range(min_val, max_val):
	health_bar.min_value = min_val
	health_bar.max_value = max_val