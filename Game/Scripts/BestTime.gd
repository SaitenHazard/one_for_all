extends Label

onready var Player = get_node('/root/MainScene/Player')

func _process(delta):
	if Player.get_start():
		self.visible = false
