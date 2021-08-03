extends TextureRect

func _ready():
	get_tree().paused = true
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().paused = false
