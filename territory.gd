extends Area3D

signal watched_exited
signal watched_entered

var watch_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_to_watchlist(watchee):
	watch_list.push(watchee)

func remove_from_watchlist(member):
	var member_index = watch_list.find(member)
	# -1 is the value that Array.find returns if there is no match
	if (member_index != -1):
		watch_list.remove_at(member_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
