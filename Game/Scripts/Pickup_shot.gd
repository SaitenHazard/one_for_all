extends Area2D

onready var Player = get_node('/root/MainScene/Player')

func _on_Pickup_shot_body_entered(body):
	Player.shots_remaining_add()
	self.queue_free()
