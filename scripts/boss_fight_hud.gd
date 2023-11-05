extends Control

@export var health_bar: ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_health_bar(health):
	health_bar.value = health

func set_health_bar_range(min_val, max_val):
	health_bar.min_value = min_val
	health_bar.max_value = max_val

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
