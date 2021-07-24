extends Area2D

func _on_Doom_body_entered(body):
	if body.name == "Player":
		body.reset_to_checkpoint()
