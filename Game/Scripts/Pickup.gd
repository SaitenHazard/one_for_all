extends Area2D



func body_entered(body):
	if body.name == 'Player':
		body.remaining_shots_add()
		self.queue_free()
