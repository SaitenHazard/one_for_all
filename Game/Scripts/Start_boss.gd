extends Area2D

onready var Boss = get_node('/root/MainScene/Enemies/Boss')

func _on_Doom_body_entered(body):
	if body.name == "Player":
		Boss.start_boss()
